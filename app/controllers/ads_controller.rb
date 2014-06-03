class AdsController < ApplicationController
	before_action :set_package, except: [:pricing, :preview, :publish, :subregion_options, :new]
  before_action :set_user
  before_action :authenticate_user!
  before_action :set_ad, only: [:preview, :publish, :edit_horse]
  before_action :set_fav_ad, only: [:like, :dislike]

  def horse
    @ad = @package.horses.new
  end

  def pricing
    @horsePackages = Package.where(type_id: 1)
    @studPackages = Package.where(type_id: 2)
    @trailerPackages = Package.where(type_id: 4)
    @tackPackages = Package.where(type_id: 3)
    @realEstatePackages = Package.where(type_id: 5)
    @servicePackages = Package.where(type_id: 6)
  end

  def preview
    @ad_banner = Picture.find(Ad.last.picture_id)
  end

  def publish
    unless Ad.last.published?
      Ad.last.publish!
    end
    respond_to do |format|
      if Ad.last.published?
        format.html { redirect_to @ad, notice: 'Ad was successfully published.' }
      else 
        format.html { render action: 'preview' }
      end
    end

  end
 
  def edit_horse
  end


  def like
    
    respond_to do |format|
      if @ad.liked_by @user
        format.html {redirect_to root_url}
        format.js
      end  
    end 
  end

  def dislike
    @ad.unliked_by @user
    redirect_to root_url
  end

  def subregion_options
    render partial: 'ads/shared/subregion_select'
  end

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
