class ServicesController < ApplicationController
  before_action :set_user
  before_action :set_service, only: [:show, :preview, :publish, :edit, :update, :destroy]

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
  end

  # GET /services/1/edit
  def edit
  end

  # POST /packages/:package_id/services
  # TODO -> Refactor this method
  def create
    @service = Service.new(service_params)
    @service.user_id = @user.id

    @ad = @service.build_ad
    @ad.user_id = @user.id
    @ad.package_id = params[:package_id]

    respond_to do |format|
      if @service.save
        unless params[:service][:pictures].nil?
          params[:service][:pictures].each do |picture|
             @service.pictures.create(name: picture)
          end
        end

        unless params[:service][:videos].nil?
          params[:service][:videos].each do |video|
             @service.videos.create(name: picture)
          end
        end
        @ad.picture_id = @service.pictures.first.id
        if @ad.save!
         format.html { redirect_to preview_service_url(@service), notice: 'Ad Service Saved!' }
        end
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /services/1
  # TODO -> update for tacks picture & video
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /services/1
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
    end
  end

  # GET /services/:id/preview
  def preview
  end

  # PUT /services/:id/publish
  def publish
    respond_to do |format|
      if @service.ad.publish!
        format.html { redirect_to @service, notice: 'Ad was successfully published.' }
      else
        format.html { render action: 'preview' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :description, :company, :company_description)
    end
end
