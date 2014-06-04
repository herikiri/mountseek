class StudsController < ApplicationController
  before_action :set_user
  before_action :set_stud, only: [:show, :preview, :publish, :edit, :update, :destroy]

  def index
    @studs = Stud.all
  end

  # GET /packages/:package_id/studs/new
  def new
    @stud = Package.find(params[:package_id]).studs.new
  end

  # POST /packages/:package_id/studs
  # TODO -> Refactor this method
  def create
    @stud = Stud.new(stud_params)
    @stud.user_id = @user.id
    
    @ad = @stud.build_ad
    @ad.user_id = @user.id
    @ad.package_id = params[:package_id]
   

    respond_to do |format|
      if @stud.save 
        unless params[:stud][:pictures].nil?
          params[:stud][:pictures].each do |picture|
             @stud.pictures.create(name: picture)
          end
        end

        unless params[:stud][:videos].nil?
          params[:stud][:videos].each do |video|
             @stud.videos.create(name: picture)
          end
        end

        @ad.picture_id = @stud.pictures.first.id
        if @ad.save!
         format.html { redirect_to preview_stud_url(@stud), notice: 'Ad Horse Saved!' }
        end
      else
        format.html { render action: 'new', notice: 'Save Horse Failed!'  }
      end
    end
  end

  # GET /studs/:id/edit
  def edit
  end

  # PATCH/PUT /studs/:id
  # TODO -> update for studs picture & video
  def update
    respond_to do |format|
      if @stud.update(stud_params)
        format.html { redirect_to @stud, notice: 'Horse was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /studs/:id
  def destroy
    @stud.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end

  # GET /studs/:id/preview
  def preview
  end

  # PUT /studs/:id/publish
  def publish
    respond_to do |format|
      if @stud.ad.draft?
        @stud.ad.publish!
      else
        format.html { redirect_to @stud, notice: 'Ad was successfully published.' }
      end
    end
  end

  private 
    # Never trust parameters from the scary internet, only allow the white list through.
    def stud_params
      params.require(:stud).permit(:title, :description, :name, :gender,
        :city, :state, :zip_code, :ad_for, :price, :private_treaty,
        :birth, :color, :height, :weight)
    end

    def set_stud
      @stud = Stud.find(params[:id])
    end

    def set_user
      @user = current_user
    end
end
