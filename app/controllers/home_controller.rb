class HomeController < ApplicationController
  def index
  	@user = current_user
  	@horses = Horse.all
  end
end

