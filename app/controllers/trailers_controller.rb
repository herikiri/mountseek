class TrailersController < ApplicationController
	before_action :set_user, only: [:like, :dislike]
  before_action :set_trailer, except: [:index, :create, :search, :new]
  before_action :authenticate_user!, only: [:new, :like, :dislike]
  before_action :set_items_gallery, only: [:show, :preview]

  impressionist :actions=>[:show]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  def index
    @trailers = Trailer.all
  end

  # GET /trailers/:id
  def show
  end

  # GET /packages/:package_id/trailers/new
  def new
  	@trailer = Package.find(params[:package_id]).trailers.new
    gon.image_upload_limit = @trailer.package.max_photo_upload
    gon.video_upload_limit = @trailer.package.max_video_upload
  end


  # GET /trailers/:id/edit
  def edit
  end


  def create
    @trailer = Trailer.new(trailer_params)
    @trailer.user_id = current_user.id

    respond_to do |format|
      if @trailer.save 
         unless params[:trailer][:pictures].nil?
          params[:trailer][:pictures].each do |picture|
              @trailer.pictures.create(name: picture)
          end
          @trailer.update(banner: @trailer.pictures.first.id)
        end

        unless params[:trailer][:videos].nil?
          params[:trailer][:videos].each do |video|
             @trailer.videos.create(name: picture)
          end
        end

        format.html { redirect_to preview_trailer_url(@trailer), notice: 'Ad Trailer Saved!' }
      else
        format.html { render :new, notice: 'Save Trailer Failed!'  }
      end
    end
  end

  # PATCH/PUT /trailers/:id
  # TODO -> update for trailer picture & video
  def update
    respond_to do |format|
      if @trailer.update(trailer_params)
        format.html { redirect_to preview_trailer_url(@trailer), notice: 'Trailer was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /trailers/:id
  def destroy
    @trailer.destroy
    respond_to do |format|
      format.html { redirect_to ads_profiles_url }
    end
  end

  # GET /trailers/:id/preview
  def preview
  end

  # PUT /trailers/:id/publish
  def publish
  end

  # GET /trailers/:id/unpublish
  def unpublish
  end

  # GET /horses/:id/activate
  def activate
    respond_to do |format|
      if @trailer.draft?
        @trailer.publish!
        @trailer.update(published_at: DateTime.now,
          published_end: DateTime.now + @trailer.package.duration.month)
        format.html { redirect_to @trailer, notice: 'Ad was successfully published.' }
      else
        format.html { render :preview }
      end
    end
  end

  # GET /horses/:id/unactivate
  def unactivate
    respond_to do |format|
      if @trailer.published?
        @trailer.remove!
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully unpublished.' }
      else
        format.html { redirect_to unpublish_trailer_url }
      end
    end
  end

  # GET /horses/:id/sold
  def sold
  end

  # GET /horses/:id/mark-sold
  def mark_sold
    respond_to do |format|
      if @trailer.published? || @trailer.removed?
        @trailer.make_sold! if @trailer.published?
        @trailer.to_sold! if @trailer.removed?
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully Mark As Sold' }
      else
        format.html { redirect_to sold_trailer_url }
      end
    end
  end

  def like
    @trailer.liked_by @user
  end

  def dislike
    @trailer.unliked_by @user
  end

  def search
    unless params[:q].blank?
      @params_q = params[:q]
      @trailers = Trailer.search(params[:q]).result
    else
      @trailers =  Trailer.all
    end

    sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
    sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
    sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
    sort_by = {price: :asc} if params[:sort_by] == "low_to_high"

    @trailers = @trailers.order(sort_by).published.live

    smart_listing_create(:trailers, @trailers, partial: "trailers/trailer_list")
  end

  private 
    # Use callbacks to share common setup or constraints between actions.
    def set_trailer
      @trailer = Trailer.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_items_gallery
      @items_gallery = @trailer.pictures + @trailer.videos
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trailer_params
      params.require(:trailer).permit(:title, :description, :brand, :model, 
        :material, :city, :state, :zip_code, :year, :price, :private_treaty, :package_id,
        :color, :hitch, :axles, :hauls, :user_name, :farm_name, :email, :website, :phone_number, :alt_phone_number)
    end
end


