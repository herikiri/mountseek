class StudsController < ApplicationController
  before_action :set_user

  def index
  end

   # GET /packages/:package_id/studs/new
  def new
  	#@stud = Package.find(params[:package_id]).stud
  end


  private 
    def set_user
      @user = current_user
    end
end
