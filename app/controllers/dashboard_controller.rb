class DashboardController < ApplicationController
	before_action :set_user

  def index
  end


  def edit
  end

  def update
  	respond_to do |format|
      if @user.profile.update(profile_param)
        format.html { redirect_to dashboard_url, notice: 'Profile was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end


  def ads
  	@ads = @user.ads
  end

  private 
  	def set_user
      @user = current_user
    end

    def profile_param
    	params.require(:profile).permit(:name, :farm_name, :phone_number, :alt_phone_number, :website, :zipcode, :city, :state, :about)
    end
end
