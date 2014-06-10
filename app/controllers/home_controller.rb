class HomeController < ApplicationController
	before_action :set_user

	include SmartListing::Helper::ControllerExtensions
	helper  SmartListing::Helper

  def index
  	@user = current_user
  	@featured_horses = Horse.featured_ad.published.limit(20)
  	@newest_horses = Horse.newest_ad.published.limit(10)
  	@search = Horse.search(params[:q])
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

