class ProfilesController < ApplicationController
	include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :set_items

  def index
  end

  def about
  end

  def favorites
  end

	def ads
		

  	sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
    sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
    sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
    sort_by = {price: :asc} if params[:sort_by] == "low_to_high"

    @horses = @horses.order(sort_by).published.active

  	smart_listing_create(:horses, @horses, partial: "profiles/horse_list")
  end


  private
    def set_items
      if params[:id]
        @horses = User.find(params[:id]).horses
        @user = User.find(params[:id])
      else 
        @horses = current_user.horses
        @user = current_user
      end
    end

end


    