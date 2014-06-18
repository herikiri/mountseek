class HorsesController < ApplicationController
  before_action :set_user, only: [:like, :dislike]
  before_action :set_horse, except: [:index, :create, :search, :new]
  before_action :authenticate_user!, only: [:new, :like, :dislike]
  before_action :set_items_gallery, only: [:show, :preview]

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
          params[:horse][:pictures].each do |picture|
            @horse.pictures.create(name: picture)
          end
          @horse.update(banner: @horse.pictures.first.id)
        end

        unless params[:horse][:videos].nil?
          params[:horse][:videos].each do |video|
            @horse.videos.create(name: video)
          end
        end

        unless params[:horse][:rideabilities_attributes]["0"][:name].nil?
          params[:horse][:rideabilities_attributes]["0"][:name].each do |rideability|
             @horse.rideabilities.create(name: rideability) unless rideability.empty?
          end
        end
        
        format.html { redirect_to preview_horse_url(@horse), notice: 'Ad Horse Saved!' }
      else
        format.html { render :new }
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
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /horses/:id
  def destroy
    @horse.destroy
    respond_to do |format|
      format.html { redirect_to ads_profiles_url }
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
      @search = Horse.search(params[:q])
      @horses = @search.result
    else
      @horses =  Horse.all
    end

    sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
    sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
    sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
    sort_by = {price: :asc} if params[:sort_by] == "low_to_high"

    @horses = @horses.order(sort_by).published.live

    smart_listing_create(:horses, @horses, partial: "horses/horse_list")
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
        disciplines_attributes: [:id, :name, :experience, :_destroy])
    end

end

