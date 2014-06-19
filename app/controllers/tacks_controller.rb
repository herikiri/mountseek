class TacksController < ApplicationController
  before_action :set_user, only: [:like, :dislike]
  before_action :set_tack, except: [:index, :create, :search, :new]
  before_action :authenticate_user!, only: [:new, :like, :dislike]
  before_action :set_items_gallery, only: [:show, :preview]

  impressionist :actions=>[:show]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  # GET /tacks
  def index
    @tacks = Tack.all
  end

  # GET /tacks/1
  def show
  end

  # GET /packages/:package_id/tacks/new
  def new
    @tack = Package.find(params[:package_id]).tacks.new
    @tack.disciplines.new
  end

  # GET /tacks/:id/edit
  def edit
  end

  # POST /packages/:package_id/tacks
  # TODO -> Refactor this method
  def create
    @tack = Tack.new(tack_params)
    @tack.user_id = current_user.id

    respond_to do |format|
      if @tack.save
      	unless params[:tack][:pictures].nil?
          params[:tack][:pictures].each do |picture|
            @tack.pictures.create(name: picture)
          end
          @tack.update(banner: @tack.pictures.first.id)
        end

        unless params[:tack][:videos].nil?
          params[:tack][:videos].each do |video|
            @tack.videos.create(name: picture)
          end
        end

        format.html { redirect_to preview_tack_url(@tack), notice: 'Ad Horse Saved!' }
      else
        format.html { render :new, notice: 'Save Tack Failed!' }
      end
    end
  end

  # PATCH/PUT /tacks/:id
  # TODO -> update for tacks picture & video
  def update
    respond_to do |format|
      if @tack.update(tack_params)
        format.html { redirect_to preview_tack_url(@tack), notice: 'Tack was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tacks/1
  def destroy
    @tack.destroy
    respond_to do |format|
      format.html { redirect_to ads_profiles_url }
    end
  end

  # GET /tacks/:id/preview
  def preview
  end

  # PUT /tacks/:id/publish
  def publish
  end

  # GET /tacks/:id/unpublish
  def unpublish
  end

  # GET /horses/:id/activate
  def activate
    respond_to do |format|
      if @tack.draft?
        @tack.publish!
        @tack.update(published_at: DateTime.now,
          published_end: DateTime.now + @tack.package.duration.month)
        format.html { redirect_to @tack, notice: 'Ad was successfully published.' }
      else
        format.html { render :preview }
      end
    end
  end

  # GET /horses/:id/unactivate
  def unactivate
    respond_to do |format|
      if @tack.published?
        @tack.remove!
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully unpublished.' }
      else
        format.html { redirect_to unpublish_tack_url }
      end
    end
  end

  # GET /horses/:id/sold
  def sold
  end

  # GET /horses/:id/mark-sold
  def mark_sold
    respond_to do |format|
      if @tack.published? || @tack.removed?
        @tack.make_sold! if @tack.published?
        @tack.to_sold! if @tack.removed?
        format.html { redirect_to ads_profiles_url, notice: 'Ad was successfully Mark As Sold' }
      else
        format.html { redirect_to sold_tack_url }
      end
    end
  end

  def like
    @tack.liked_by @user
  end

  def dislike
    @tack.unliked_by @user
  end

  def search
    unless params[:q].blank?
      @params_q = params[:q]
      @search = Tack.search(params[:q])
      @tacks = @search.result
    else
      @tacks =  Tack.all
    end

    sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
    sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
    sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
    sort_by = {price: :asc} if params[:sort_by] == "low_to_high"

    @tacks = @tacks.order(sort_by).published.live

    smart_listing_create(:horses, @horses, partial: "tacks/tack_list")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tack
      @tack = Tack.find(params[:id])
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_items_gallery
      @items_gallery = @tack.pictures + @tack.videos
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tack_params
      params.require(:tack).permit(:title, :description, :price, :tack, :type, :condition, :color,
        :user_name, :farm_name, :email, :website, :phone_number, :alt_phone_number, :package_id,
        disciplines_attributes: [:id, :name, :experience, :_destroy])
    end
    
end
