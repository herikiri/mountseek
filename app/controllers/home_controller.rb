class HomeController < ApplicationController
  def index
  	@user = current_user
  	@ads_horse = Ad.where(adable_type: "Horse")
  end
end
