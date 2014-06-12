class ProfilesController < ApplicationController
	include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

	def ads
		if params[:id]
  		@horses = User.find(params[:id]).horses
  	else 
  		@horses = current_user.horses
  	end

  	sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
    sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
    sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
    sort_by = {price: :asc} if params[:sort_by] == "low_to_high"

    @horses = @horses.order(sort_by).published.active

  	smart_listing_create(:horses, @horses, partial: "profiles/horse_list")
  end

end


    