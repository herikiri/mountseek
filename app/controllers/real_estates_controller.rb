class RealEstatesController < ApplicationController
  before_action :set_user, only: [:like, :dislike]
  before_action :set_real_estate, except: [:index, :create, :search, :new]
  before_action :authenticate_user!, only: [:new, :like, :dislike]
  before_action :set_items_gallery, only: [:show, :preview]

  impressionist :actions=>[:show]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @real_estates = RealEstate.all
  end

   # GET /real_estates/1
  def show
  end

  # GET /packages/:package_id/real_estates/new
  def new
    @real_estate = Package.find(params[:package_id]).real_estates.new
  end

  # GET /real_estates/:id/edit
  def edit
  end


  def create
    @real_estate = RealEstate.new(real_estate_params)
    @real_estate.user_id = current_user.id
    
    respond_to do |format|
      if @real_estate.save 
        unless params[:real_estate][:pictures].nil?
          params[:real_estate][:pictures].each do |picture|
             @real_estate.pictures.create(name: picture)
          end
          @real_estate.update(banner: @real_estate.pictures.first.id)
        end

        unless params[:real_estate][:videos].nil?
          params[:real_estate][:videos].each do |video|
             @real_estate.videos.create(name: picture)
          end
        end

        format.html { redirect_to preview_real_estate_url(@real_estate), notice: 'Ad Trailer Saved!' }
      else
        format.html { render :new, notice: 'Save Trailer Failed!' }
      end
    end
  end


  # PATCH/PUT /real_estates/:id
  # TODO -> update for real_estates picture & video
  def update
    respond_to do |format|
      if @real_estate.update(real_estate_params)
        format.html { redirect_to preview_real_estate_url(@real_estate), notice: 'Real Estate was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /real_estates/:id
  def destroy
    @real_estate.destroy
    respond_to do |format|
      format.html { redirect_to ads_profiles_url }
    end
  end

  # GET /real_estates/:id/preview
  def preview
  end

  # GET /real_estates/:id/publish
  def publish
  end

  # GET /real_estates/:id/unpublish
  def unpublish
  end

  # GET /real_estates/:id/activate
  def activate
    respond_to do |format|
      if @real_estate.draft?
        @real_estate.publish!
        @real_estate.update(published_at: DateTime.now,
          published_end: DateTime.now + @real_estate.package.duration.month)
        format.html { redirect_to @real_estate, notice: 'Ad was successfully published.' }
      else
        format.html { render :preview }
      end
    end
  end

  # GET /real_estates/:id/unactivate
  def unactivate
    respond_to do |format|
      if @real_estate.published?
        @real_estate.remove!
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully unpublished.' }
      else
        format.html { redirect_to unpublish_real_estate_url }
      end
    end
  end

  # GET /real_estate/:id/sold
  def sold
  end

  # GET /real_estate/:id/mark-sold
  def mark_sold
    respond_to do |format|
      if @real_estate.published? || @real_estate.removed?
        @real_estate.make_sold! if @real_estate.published?
        @real_estate.to_sold! if @real_estate.removed?
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully Mark As Sold' }
      else
        format.html { redirect_to sold_real_estate_url }
      end
    end
  end

  def like
    @real_estate.liked_by @user
  end

  def dislike
    @real_estate.unliked_by @user
  end

  def search
    unless params[:q].blank?
      @params_q = params[:q]
      @search = real_estate.search(params[:q])
      @real_estates = @search.result
    else
      @real_estates =  RealEstate.all
    end

    sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
    sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
    sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
    sort_by = {price: :asc} if params[:sort_by] == "low_to_high"

    @real_estates = @real_estates.order(sort_by).published.live

    smart_listing_create(:real_estates, @real_estates, partial: "real_estates/real_estate_list")
  end

  private 
    # Use callbacks to share common setup or constraints between actions.
    def set_real_estate
      @real_estate = RealEstate.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_items_gallery
      @items_gallery = @real_estate.pictures + @real_estate.videos
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def real_estate_params
      params.require(:real_estate).permit(:title, :description, :house_style, :house_type, :package_id,
        :country, :city, :state, :zip_code, :price, :private_treaty,
        :year, :sqft, :bedroom, :bathroom, :floor, :garage, 
        :user_name, :farm_name, :email, :website, :phone_number, :alt_phone_number)
    end
end
