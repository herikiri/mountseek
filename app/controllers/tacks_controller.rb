class TacksController < ApplicationController
  before_action :set_user
  before_action :set_tack, only: [:show, :preview, :publish, :edit, :update, :destroy]

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
  end

  # GET /tacks/:id/edit
  def edit
  end

  # POST /packages/:package_id/tacks
  # TODO -> Refactor this method
  def create
    @tack = Tack.new(tack_params)
    @tack.user_id = @user.id

    @ad = @tack.build_ad
    @ad.user_id = @user.id
    @ad.package_id = params[:package_id]

    respond_to do |format|
      if @tack.save
      	unless params[:tack][:pictures].nil?
          params[:tack][:pictures].each do |picture|
             @tack.pictures.create(name: picture)
          end
        end

        unless params[:tack][:videos].nil?
          params[:tack][:videos].each do |video|
             @tack.videos.create(name: picture)
          end
        end
        @ad.picture_id = @tack.pictures.first.id
        if @ad.save!
         format.html { redirect_to preview_tack_url(@tack), notice: 'Ad Horse Saved!' }
        end
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tacks/:id
  # TODO -> update for tacks picture & video
  def update
    respond_to do |format|
      if @tack.update(tack_params)
        format.html { redirect_to @tack, notice: 'Tack was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tacks/1
  def destroy
    @tack.destroy
    respond_to do |format|
      format.html { redirect_to tacks_url, notice: 'Tack was successfully destroyed.' }
    end
  end

  # GET /tacks/:id/preview
  def preview
  end

  # PUT /tacks/:id/publish
  def publish
    respond_to do |format|
      if @tack.ad.publish!
        format.html { redirect_to @tack, notice: 'Ad was successfully published.' }
      else
        format.html { render action: 'preview' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tack
      @tack = Tack.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tack_params
      params.require(:tack).permit(:title, :description, :price, :tack, :type, :discipline, :condition, :color)
    end
    
end
