class HorsesController < ApplicationController
  before_action :set_user
  before_action :set_horse, only: [:show, :preview, :publish, :edit, :update, :destroy]
  impressionist

  def index
    @horses = Horse.all
  end

  # GET /packages/:package_id/horses/new
  def new
    @horse = Package.find(params[:package_id]).horses.new
  end

  # POST /packages/:package_id/horses
  # TODO -> Refactor this method
  def create
    @horse = Horse.new(horse_params)
    @horse.user_id = @user.id
    
    @ad = @horse.build_ad
    @ad.user_id = @user.id
    @ad.package_id = params[:package_id]
   

    respond_to do |format|
      if @horse.save 
        unless params[:horse][:pictures].nil?
          params[:horse][:pictures].each do |picture|
             @horse.pictures.create(name: picture)
          end
        end

        unless params[:horse][:videos].nil?
          params[:horse][:videos].each do |video|
             @horse.videos.create(name: picture)
          end
        end

        @ad.picture_id = @horse.pictures.first.id
        if @ad.save!
         format.html { redirect_to preview_horse_url(@horse), notice: 'Ad Horse Saved!' }
        end
      else
        format.html { render action: 'new', notice: 'Save Horse Failed!'  }
      end
    end
  end

  # GET /horses/:id/edit
  def edit
  end

  # PATCH/PUT /horses/:id
  # TODO -> update for horses picture & video
  def update
    respond_to do |format|
      if @horse.update(horse_params)
        format.html { redirect_to @horse, notice: 'Horse was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /horses/:id
  def destroy
    @horse.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  # GET /horses/:id/preview
  def preview
  end

  # PUT /horses/:id/publish
  def publish
    respond_to do |format|
      if @horse.ad.draft?
        @horse.ad.publish!
      else
        format.html { redirect_to @horse, notice: 'Ad was successfully published.' }
      end
    end
  end

  private 
    # Never trust parameters from the scary internet, only allow the white list through.
    def horse_params
      params.require(:horse).permit(:title, :description, :name, :gender, 
        :breed, :city, :state, :zip_code, :ad_for, :price, :private_treaty,
        :birth, :color, :height, :weight)
    end

    def set_horse
      @horse = Horse.find(params[:id])
    end

    def set_user
      @user = current_user
    end

end

