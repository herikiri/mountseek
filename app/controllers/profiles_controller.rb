class ProfilesController < ApplicationController
	include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :set_user
  before_action :set_horse, only: [:ads]
  before_action :set_smart_listing_filter, only: [:ads, :favorites]

  def index
  end

  def about
  end

  def favorites
    @horses = Horse.favorited_by(@user)
    @horses = @horses.order(@sort_by).published.active
    smart_listing_create(:horses, @horses, partial: "profiles/horse_list")
  end

	def ads
    @horses = @horses.order(@sort_by).active
    smart_listing_create(:horses, @horses, partial: "profiles/horse_list")
  end


  private
    def set_user
      if params[:id]
        @user = User.find(params[:id])
      else 
        @user = current_user
      end
    end

    def set_horse
      if params[:id]
        @horses = User.find(params[:id]).horses
      else 
        @horses = current_user.horses
      end
    end

    def set_smart_listing_filter
      @sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
      @sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
      @sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
      @sort_by = {price: :asc} if params[:sort_by] == "low_to_high"
    end

end


    