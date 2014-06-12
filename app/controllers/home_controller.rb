class HomeController < ApplicationController
	before_action :set_user

	include SmartListing::Helper::ControllerExtensions
	helper  SmartListing::Helper

  def index
  	@user = current_user
  	@featured_horses = Horse.active.published.featured_ad.limit(20)
  	@newest_horses = Horse.active.published.newest_ad.limit(10)
  	@search = Horse.search(params[:q])
  end

  def pricing
    @horsePackages = Package.where(type_id: 1)
    @studPackages = Package.where(type_id: 2)
    @trailerPackages = Package.where(type_id: 4)
    @tackPackages = Package.where(type_id: 3)
    @realEstatePackages = Package.where(type_id: 5)
    @servicePackages = Package.where(type_id: 6)
  end


  def horses
  end

  def studs
  end


  private 
  	def set_user
  		@user = current_user
  	end
end

