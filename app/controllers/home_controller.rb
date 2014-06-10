class HomeController < ApplicationController
	include SmartListing::Helper::ControllerExtensions
	helper  SmartListing::Helper

  def index
  	@user = current_user
  	@featured_horses = Horse.featured_ad.published.limit(20)
  	@newest_horses = Horse.newest_ad.published.limit(10)
  	@search = Horse.search(params[:q])
  end





end

