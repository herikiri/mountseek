class StudsController < ApplicationController
  before_action :set_user, only: [:like, :dislike]
  before_action :set_stud, except: [:index, :create, :search, :new]
  before_action :authenticate_user!, only: [:new, :like, :dislike]
  before_action :set_items_gallery, only: [:show, :preview]

  impressionist :actions=>[:show]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @studs = Stud.all
  end

   # GET /studs/1
  def show
  end

  # GET /packages/:package_id/studs/new
  def new
    @stud = Package.find(params[:package_id]).studs.new
    @stud.disciplines.new
  end

  # GET /studs/:id/edit
  def edit
  end

  # POST /packages/:package_id/studs
  # TODO -> Refactor this method
  def create
    @stud = Stud.new(stud_params)
    @stud.user_id = current_user.id
    
    respond_to do |format|
      if @stud.save 
        unless params[:stud][:pictures].nil?
          params[:stud][:pictures].each do |picture|
             @stud.pictures.create(name: picture)
          end
          @stud.update(banner: @stud.pictures.first.id)
        end

        unless params[:stud][:videos].nil?
          params[:stud][:videos].each do |video|
             @stud.videos.create(name: video)
          end
        end

        format.html { redirect_to preview_stud_url(@stud), notice: 'Ad Stud Saved!' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /studs/:id
  # TODO -> update for studs picture & video
  def update
    respond_to do |format|
      if @stud.update(stud_params)
        format.html { redirect_to preview_stud_url(@horse), notice: 'Stud was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /studs/:id
  def destroy
    @stud.destroy
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
      if @stud.draft?
        @stud.publish!
        @stud.update(published_at: DateTime.now,
          published_end: DateTime.now + @stud.package.duration.month)
        format.html { redirect_to @stud, notice: 'Ad was successfully published.' }
      else
        format.html { render :preview }
      end
    end
  end

  # GET /horses/:id/unactivate
  def unactivate
    respond_to do |format|
      if @stud.published?
        @stud.remove!
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully unpublished.' }
      else
        format.html { redirect_to unpublish_stud_url }
      end
    end
  end

  # GET /horses/:id/sold
  def sold
  end

  # GET /horses/:id/mark-sold
  def mark_sold
    respond_to do |format|
      if @stud.published? || @stud.removed?
        @stud.make_sold! if @stud.published?
        @stud.to_sold! if @stud.removed?
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully Mark As Sold' }
      else
        format.html { redirect_to sold_stud_url }
      end
    end
  end

  def like
    @stud.liked_by @user
  end

  def dislike
    @stud.unliked_by @user
  end

  def search
    unless params[:q].empty?
      @params_q = params[:q]
      @search = Stud.search(params[:q])
      @studs =  @search.result
    else
      @studs = Stud.all
    end


    sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
    sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
    sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
    sort_by = {price: :asc} if params[:sort_by] == "low_to_high"

    @studs =  @studs.order(sort_by).published.live

    smart_listing_create(:studs, @studs, partial: "studs/stud_list")

  end

  private 
    # Use callbacks to share common setup or constraints between actions.
    def set_stud
      @stud = Stud.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_items_gallery
      @items_gallery = @stud.pictures + @stud.videos
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stud_params
      params.require(:stud).permit(:title, :description, :name,
        :breed, :city, :state, :zip_code, :private_treaty,
        :birth, :color, :height, :weight, :package_id, :registration, :registration_num,
        :second_reg, :second_reg_num, :other_markings, :second_breed, :temperament, 
        :stud_fee, :booking_fee, :shipping_fee, :available, :until,
        disciplines_attributes: [:id, :name, :experience, :_destroy])
    end
end
