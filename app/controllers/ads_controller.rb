class AdsController < ApplicationController
	before_action :set_package, except: [:pricing, :preview, :publish, :subregion_options, :new]
  before_action :set_user
  before_action :authenticate_user!
  before_action :set_ad, only: [:preview, :publish, :edit_horse]
  before_action :set_fav_ad, only: [:like, :dislike]

 
  


 
  private 
  	def set_package
  		@package = Package.find(params[:id])
  	end

    def set_user
      @user = current_user
    end

    def set_ad
      @ad = Ad.last.adable_type.constantize.find(Ad.last.adable_id)
    end

    def set_fav_ad
      @ad = Ad.find(params[:id])
    end
end
