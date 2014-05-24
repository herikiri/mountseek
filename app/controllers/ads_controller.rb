class AdsController < ApplicationController
	before_action :set_package, except: [:pricing, :preview]
  before_action :set_user

  def horse
    ad = @package.horses.new
    @ad_horse = ad
  end

  def stud
  end

  def trailer
  end

  def tack
  end

  def real_estate
  end

  def service
  end


  def pricing
    @horsePackages = Package.where(type_id: 1)
    @studPackages = Package.where(type_id: 2)
    @trailerPackages = Package.where(type_id: 3)
    @tackPackages = Package.where(type_id: 4)
    @realEstatePackages = Package.where(type_id: 5)
    @servicePackages = Package.where(type_id: 6)
  end

  def preview
    ad_last = Ad.last
    @ad = ad_last.adable_type.constantize.find(ad_last.adable_id)
  end


  private 
  	def set_package
  		@package = Package.find(params[:id])
  	end

    def set_user
      @user = current_user
    end
end
