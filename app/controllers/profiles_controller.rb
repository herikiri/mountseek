class ProfilesController < ApplicationController
	include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  before_action :set_user
  before_action :set_horses, :set_studs, 
    :set_trailers, :set_real_estates, 
    :set_tacks, only: [:ads]
  before_action :set_smart_listing_filter, only: [:favorites]

  def index
  end

  def about
  end

  def favorites
    @horses = Horse.favorited_by(@user)
    @horses = @horses.order(@sort_by)
    smart_listing_create(:horses, @horses, partial: "profiles/horse_list")
  end

	def ads
    #@horses = @horses.order(@sort_by)
    #smart_listing_create(:horses, @horses, partial: "profiles/horse_list")
  end


  private
    def set_user
      if params[:id]
        @user = User.find(params[:id])
      else 
        @user = current_user
      end
    end

    def set_horses
      if params[:id]
        @horses = User.find(params[:id]).horses.published
      else 
        @horses = current_user.horses
      end
    end

    def set_studs
      if params[:id]
        @studs = User.find(params[:id]).studs.published
      else 
        @studs = current_user.studs
      end
    end

    def set_trailers
      if params[:id]
        @trailers = User.find(params[:id]).trailers.published
      else 
        @trailers = current_user.trailers
      end
    end

    def set_real_estates
      if params[:id]
        @real_estates = User.find(params[:id]).real_estates.published
      else 
        @real_estates = current_user.real_estates
      end
    end

    def set_tacks
      if params[:id]
        @tacks = User.find(params[:id]).tacks.published
      else 
        @tacks = current_user.tacks
      end
    end

    def set_smart_listing_filter
      @sort_by = {updated_at: :desc} if params[:sort_by] == "newest" || params[:sort_by].nil?
      @sort_by = {updated_at: :asc} if params[:sort_by] == "oldest"
      @sort_by = {price: :desc} if params[:sort_by] == "high_to_low"
      @sort_by = {price: :asc} if params[:sort_by] == "low_to_high"
    end

end


    