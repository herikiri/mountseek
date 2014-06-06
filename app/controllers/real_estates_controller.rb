class RealEstatesController < ApplicationController
  before_action :set_user
  before_action :set_real_estate, only: [:show, :preview, :publish, :edit, :update, :destroy]

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

  # POST /packages/:package_id/real_estates
  # TODO -> Refactor this method
  def create
    @real_estate = RealEstate.new(real_estate_params)
    @real_estate.user_id = @user.id
    
    @ad = @real_estate.build_ad
    @ad.user_id = @user.id
    @ad.package_id = params[:package_id]
   

    respond_to do |format|
      if @real_estate.save 
        unless params[:real_estate][:pictures].nil?
          params[:real_estate][:pictures].each do |picture|
             @real_estate.pictures.create(name: picture)
          end
        end

        unless params[:real_estate][:videos].nil?
          params[:real_estate][:videos].each do |video|
             @real_estate.videos.create(name: picture)
          end
        end

        @ad.picture_id = @real_estate.pictures.first.id
        if @ad.save!
         format.html { redirect_to preview_real_estate_url(@real_estate), notice: 'Ad Horse Saved!' }
        end
      else
        format.html { render action: 'new', notice: 'Save Horse Failed!'  }
      end
    end
  end


  # PATCH/PUT /real_estates/:id
  # TODO -> update for real_estates picture & video
  def update
    respond_to do |format|
      if @real_estate.update(real_estate_params)
        format.html { redirect_to @real_estate, notice: 'Horse was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /real_estates/:id
  def destroy
    @real_estate.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  # GET /real_estates/:id/preview
  def preview
  end

  # PUT /real_estates/:id/publish
  def publish
    respond_to do |format|
      if @real_estate.ad.draft?
        @real_estate.ad.publish!
        format.html { redirect_to @real_estate, notice: 'Ad was successfully published.' }
      else
        format.html { redirect_to @real_estate, notice: 'Ad was successfully published.' }
      end
    end
  end

  private 
    # Never trust parameters from the scary internet, only allow the white list through.
    def real_estate_params
      params.require(:real_estate).permit(:title, :description, :house_style, :house_type,
        :country_location, :city, :state, :zip_code, :ad_for, :price, :private_treaty,
        :year, :sqft, :bedroom, :bathroom, :floor, :garage)
    end

    def set_real_estate
      @real_estate = RealEstate.find(params[:id])
    end

    def set_user
      @user = current_user
    end
end
