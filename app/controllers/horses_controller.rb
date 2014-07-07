class HorsesController < ApplicationController
  before_action :set_user, only: [:like, :dislike]
  before_action :set_horse, except: [:index, :create, :search, :new, :youtube_upload]
  before_action :authenticate_user!, only: [:new, :like, :dislike]
  before_action :set_items_gallery, only: [:show, :preview]
  before_action :set_yt_client, only: [:create]
  #before_action :set_rideability_params, only: [:create]

  impressionist :actions=>[:show]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @horses = Horse.all
  end

  # GET /horses/1
  def show
  end

  # GET /packages/:package_id/horses/new
  def new
    @horse = Package.find(params[:package_id]).horses.new
    @horse.disciplines.new
    @horse.rideabilities.new
    @horse.videos.new
    gon.image_upload_limit = @horse.package.max_photo_upload
    gon.video_upload_limit = @horse.package.max_video_upload
    gon.session_oauth2_result = session[:oauth2_result] if session[:oauth2_result].size > 0 || session[:oauth2_result]
    session[:redirect_uri] = "/packages/"+params[:package_id]+"/horses/new"
  end

    # GET /horses/:id/edit
  def edit
  end

  def create
    @horse = Horse.new(horse_params)
    @horse.user_id = current_user.id
    
    respond_to do |format|
      if @horse.save 
        unless params[:horse][:pictures].nil?
          sliced_horse_pictures = horse_pictures_param
          sliced_horse_pictures = horse_pictures_param.slice(0, @horse.package.max_photo_upload) if horse_pictures_param.size > @horse.package.max_photo_upload
          @horse.update(banner: @horse.pictures.first.id) if @horse.pictures.create(sliced_horse_pictures)
        end

        unless @rideability_params.blank?
          @horse.rideabilities.create(@rideability_params) 
        end

        unless params[:horse][:videos].nil?
          regex_format = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
          
          params[:horse][:videos].each do |horse_video|
            video = File.open(horse_video.tempfile)
            video_result = @yt_client.video_upload(video, :title => "test",:description => 'some description', :category => 'People',:keywords => %w[cool blah test])

            @horse.videos.create(link: video_result.media_content[0].url)            
          end


        end
        format.html { redirect_to preview_horse_url(@horse), notice: 'Ad Horse Saved!' }
      else
        format.html { render :new, notice: 'Save Horse Failed!' }
      end
    end
  end

  # PATCH/PUT /horses/:id
  # TODO -> update for horses picture & video
  def update
    respond_to do |format|
      if @horse.update(horse_params)
        format.html { redirect_to preview_horse_url(@horse), notice: 'Horse was successfully updated.' }
      else
        format.html { render  :edit }
      end
    end
  end

  # DELETE /horses/:id
  def destroy
    @horse.destroy
    respond_to do |format|
      format.html { redirect_to ads_profiles_url, notice: 'Horse was successfully destroyed.' }
    end
  end

  # GET /horses/:id/preview
  def preview
  end

  # GET /horses/:id/publish
  def publish
  end

  # GET /horses/:id/unpublish
  def unpublish
  end

  # GET /horses/:id/activate
  def activate
    respond_to do |format|
      if @horse.draft?
        @horse.publish!
        @horse.update(published_at: DateTime.now,
          published_end: DateTime.now + @horse.package.duration.month)
        format.html { redirect_to @horse, notice: 'Ad was successfully published.' }
      else
        format.html { render :preview }
      end
    end
  end

  # GET /horses/:id/unactivate
  def unactivate
    respond_to do |format|
      if @horse.published?
        @horse.remove!
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully unpublished.' }
      else
        format.html { redirect_to unpublish_horse_url }
      end
    end
  end

  # GET /horses/:id/sold
  def sold
  end

  # GET /horses/:id/mark-sold
  def mark_sold
    respond_to do |format|
      if @horse.published? || @horse.removed?
        @horse.make_sold! if @horse.published?
        @horse.to_sold! if @horse.removed?
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully Mark As Sold' }
      else
        format.html { redirect_to sold_horse_url }
      end
    end
  end

  def like
    @horse.liked_by @user
  end

  def dislike
    @horse.unliked_by @user
  end

  def search
    unless params[:q].blank?
      @params_q = params[:q]
      @horses = Horse.search(params[:q]).result
    else
      @horses =  Horse.all
    end

    sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
    sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
    sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
    sort_by = {price: :asc} if params[:sort_by] == "low_to_high"

    @horses = @horses.order(sort_by).live

    smart_listing_create(:horses, @horses, partial: "horses/horse_list")
  end

  def youtube_upload

    redirect_to "/"
  end

  private 
    # Use callbacks to share common setup or constraints between actions.
    def set_horse
      @horse = Horse.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_items_gallery
      @items_gallery = @horse.pictures + @horse.videos
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horse_params
      params.require(:horse).permit(:title, :description, :name, :gender, 
        :breed, :city, :state, :zip_code, :ad_for, :price, :private_treaty,
        :birth, :color, :height, :weight, :package_id, :registration, :registration_num,
        :second_reg, :second_reg_num, :other_markings, :second_breed, :temperament,
        :user_name, :farm_name, :email, :website, :phone_number, :alt_phone_number,
        disciplines_attributes: [:id, :name, :experience, :_destroy],
        videos_attributes: [:id, :link, :_destroy])
    end

    def horse_pictures_param
      pictures = []
      params[:horse][:pictures].each do |picture|
        pictures << {name: picture}
      end
      pictures
    end

    def set_rideability_params
      @rideability_params = []
      params[:horse][:rideabilities_attributes]["0"][:name].each do |rideability|
        @rideability_params << {name: rideability}
      end
      
    end

    def set_yt_client
      @yt_client = Video.yt_client(session[:oauth2_result]) if session[:oauth2_result]
    end

end

