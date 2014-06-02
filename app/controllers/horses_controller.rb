class HorsesController < ApplicationController
  before_action :set_user
  before_action :set_horse, only: [:show, :update]
  
  def create
  	@horse = Horse.new(horse_params)
    @horse.user_id = @user.id
    
    ad = @horse.ads.new
    ad.user_id = @user.id
    ad.package_id = @horse.package.id
   

    respond_to do |format|
      if @horse.save 
        params[:horse][:pictures].each do |picture|
           @horse.pictures.create(name: picture)
        end

        ad.picture_id = @horse.pictures.first.id
        if ad.save!
      	 format.html { redirect_to preview_ad_url(@horse), notice: 'Ad Horse Saved!' }
        end
      else
        format.html { render place_horse_url(@horse), notice: 'Save Horse Failed!'  }
      end
    end
  end

  def update
    ad = Ad.find_by(adable_id: @horse.id)
    ad_horse_banner = Picture.find(ad.picture_id)
    respond_to do |format|
      if @horse.update(horse_params) &&  ad_horse_banner.update(name: picture_param[:pictures])
        format.html { redirect_to preview_ad_url(@horse), notice: 'Ad Horse was successfully updated.' }
      else
        format.html { render place_horse_edit(@horse), notice: 'Update Horse Failed!'  }
      end
    end
  end

  def show
    ad = Ad.find_by(adable_id: @horse.id)
    @ad_banner = Picture.find(ad.picture_id)
    impressionist(@horse)
  end



  private 
  	def horse_params
      params.require(:horse).permit(:title, :description, :zip_code, :city, :state, :price, :private_treaty, :ad_for, :name, :gender, :breed, :birth, :color, :height, :weight, :user_id, :package_id)
    end


    def set_user
      @user = current_user
    end

    def set_horse
      @horse = Horse.find(params[:id])
    end

end

