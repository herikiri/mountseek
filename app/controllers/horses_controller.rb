class HorsesController < ApplicationController
  before_action :set_user

  def create

  	horse = Horse.new(horse_params)
    horse.user_id = @user.id
    
    ad = horse.ads.new
    ad.user_id = @user.id
    ad.package_id = horse.package.id
    horse_pictures = horse.pictures.new(name: picture_param[:pictures])

    respond_to do |format|
      if horse.save && ad.save! && horse_pictures.save!
      	format.html { redirect_to preview_ad_url(horse), notice: 'Ad Horse Saved!' }
      else
        format.html { render place_horse_url(horse), notice: 'Save Horse Failed!'  }
      end
    end
  end

  private 
  	def horse_params
      params.require(:horse).permit(:title, :description, :zip_code, :city, :state, :price, :private_treaty, :ad_for, :name, :gender, :breed, :birth, :color, :height, :weight, :user_id, :package_id)
    end

    def picture_param
      params.require(:horse).permit(:pictures)
    end

    def set_user
      @user = current_user
    end

end

