class TrailersController < ApplicationController
	
	before_action :set_user

  def index
  end

   # GET /packages/:package_id/trailers/new
  def new
  	@trailer = Package.find(params[:package_id]).trailers.new
  end


  private 
    def set_user
      @user = current_user
    end
end
