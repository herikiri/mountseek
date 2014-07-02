class ServicesController < ApplicationController
  before_action :set_user, only: [:like, :dislike]
  before_action :set_service, except: [:index, :create, :search, :new]
  before_action :authenticate_user!, only: [:new, :like, :dislike]
  before_action :set_items_gallery, only: [:show, :preview]

  impressionist :actions=>[:show]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper


  # GET /services
  def index
    @services = Service.all
  end

  # GET /services/1
  def show
  end

  # GET /packages/:package_id/services/new
  def new
    @service = Package.find(params[:package_id]).services.new
    @service.disciplines.new
    gon.image_upload_limit = @service.package.max_photo_upload
    gon.video_upload_limit = @service.package.max_video_upload
  end

  # GET /services/1/edit
  def edit
  end

  def create
    @service = Service.new(service_params)
    @service.user_id = current_user.id

    respond_to do |format|
      if @service.save
        unless params[:service][:pictures].nil?
          params[:service][:pictures].each do |picture|
            @service.pictures.create(name: picture)
          end
          @service.update(banner: @service.pictures.first.id)
        end

        unless params[:service][:videos].nil?
          params[:service][:videos].each do |video|
            @service.videos.create(name: picture)
          end
        end

        format.html { redirect_to preview_service_url(@service), notice: 'Ad Service Saved!' }
      else
        format.html { render :new, notice: 'Save Service Failed!' }
      end
    end
  end

  # PATCH/PUT /services/1
  # TODO -> update for tacks picture & video
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to preview_service_url(@service), notice: 'Service was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /services/1
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to ads_profiles_url, notice: 'Service was successfully destroyed.' }
    end
  end

  # GET /services/:id/preview
  def preview
  end

  # PUT /services/:id/publish
  def publish
  end

  # GET /services/:id/unpublish
  def unpublish
  end

  # GET /services/:id/activate
  def activate
    respond_to do |format|
      if @service.draft?
        @service.publish!
        @service.update(published_at: DateTime.now,
          published_end: DateTime.now + @service.package.duration.month)
        format.html { redirect_to @service, notice: 'Ad was successfully published.' }
      else
        format.html { render :preview }
      end
    end
  end

  # GET /services/:id/unactivate
  def unactivate
    respond_to do |format|
      if @service.published?
        @service.remove!
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully unpublished.' }
      else
        format.html { redirect_to unpublish_service_url }
      end
    end
  end

  # GET /services/:id/sold
  def sold
  end

  # GET /services/:id/mark-sold
  def mark_sold
    respond_to do |format|
      if @service.published? || @service.removed?
        @service.make_sold! if @service.published?
        @service.to_sold! if @service.removed?
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully Mark As Sold' }
      else
        format.html { redirect_to sold_service_url }
      end
    end
  end

  def like
    @service.liked_by @user
  end

  def dislike
    @service.unliked_by @user
  end

  def search
    unless params[:q].blank?
      @params_q = params[:q]
      @services = Service.search(params[:q]).result
    else
      @services =  Service.all
    end

    sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
    sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
    sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
    sort_by = {price: :asc} if params[:sort_by] == "low_to_high"

    @services = @services.order(sort_by).published.live

    smart_listing_create(:services, @services, partial: "services/service_list")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_items_gallery
      @items_gallery = @service.pictures + @service.videos
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :description, :company, :company_description, :service_type,
        :user_name, :farm_name, :email, :website, :phone_number, :alt_phone_number, :package_id,
        disciplines_attributes: [:id, :name, :experience, :_destroy])
    end
end
