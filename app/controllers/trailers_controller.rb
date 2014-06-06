class TrailersController < ApplicationController
	before_action :set_user
  before_action :set_trailer, only: [:show, :preview, :publish, :edit, :update, :destroy]

  def index
    @trailer = Trailer.all
  end

  # GET /trailers/:id
  def show
  end

  # GET /packages/:package_id/trailers/new
  def new
  	@trailer = Package.find(params[:package_id]).trailers.new
  end


  # GET /trailers/:id/edit
  def edit
  end

  # POST /packages/:package_id/trailers
  # TODO -> Refactor this method
  def create
    @trailer = Trailer.new(trailer_params)
    @trailer.user_id = @user.id
    
    @ad = @trailer.build_ad
    @ad.user_id = @user.id
    @ad.package_id = params[:package_id]
   

    respond_to do |format|
      if @trailer.save 
         unless params[:trailer][:pictures].nil?
          params[:trailer][:pictures].each do |picture|
             @trailer.pictures.create(name: picture)
          end
        end

        unless params[:trailer][:videos].nil?
          params[:trailer][:videos].each do |video|
             @trailer.videos.create(name: picture)
          end
        end

        @ad.picture_id = @trailer.pictures.first.id
        if @ad.save!
         format.html { redirect_to preview_trailer_url(@trailer), notice: 'Ad Trailer Saved!' }
        end
      else
        format.html { render action: 'new', notice: 'Save Trailer Failed!'  }
      end
    end
  end

  # PATCH/PUT /trailers/:id
  # TODO -> update for trailer picture & video
  def update
    if @trailer.update(trailer_params)
      format.html { redirect_to @product, notice: 'Product was successfully updated.' }
    else
      format.html { render action: 'edit' }
    end
  end

  # DELETE /trailers/:id
  def destroy
    @trailer.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  # GET /trailers/:id/preview
  def preview
  end

  # PUT /trailers/:id/publish
  def publish
    respond_to do |format|
      if @trailer.ad.publish!
        format.html { redirect_to @trailer, notice: 'Ad was successfully published.' }
      else
        format.html { render action: 'preview' }
      end
    end
  end

  private 
    # Never trust parameters from the scary internet, only allow the white list through.
    def trailer_params
      params.require(:trailer).permit(:title, :description, :brand, :model, 
        :material, :city, :state, :zip_code, :year, :price, :private_treaty,
        :color, :hitch, :axles, :hauls)
    end

    def set_trailer
      @trailer = Trailer.find(params[:id])
    end

    def set_user
      @user = current_user
    end
end


