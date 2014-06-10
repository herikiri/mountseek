class HomeController < ApplicationController
  def index
  	@user = current_user
  	@horses = Horse.featured_ad.published
  	@newest_horses = Horse.newest_ad.published.limit(10)
  	@search = Horse.search(params[:q])
  end


  def search_horses

  end


end

