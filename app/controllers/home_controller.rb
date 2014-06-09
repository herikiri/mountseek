class HomeController < ApplicationController
  def index
  	@user = current_user
  	@horses = Horse.featured_ad.published
  	@newest_horses = Horse.newest_ad.published
  end
end

