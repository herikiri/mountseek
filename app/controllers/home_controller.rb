class HomeController < ApplicationController

  def index
  	@user = current_user
  	@featured_horses = Horse.published.featured_ad.limit(20)
  	@newest_horses = Horse.published.newest_ad.limit(12)
  	@search_horse = Horse.search(params[:q])
    @search_stud = Stud.search(params[:q])
    @search_trailer = Trailer.search(params[:q])
    @search_real_estate = RealEstate.search(params[:q])
    @search_tack = Tack.search(params[:q])
    @search_service = Service.search(params[:q])
  end

  def pricing
    @horsePackages = Package.where(type_id: 1)
    @studPackages = Package.where(type_id: 2)
    @trailerPackages = Package.where(type_id: 4)
    @tackPackages = Package.where(type_id: 3)
    @realEstatePackages = Package.where(type_id: 5)
    @servicePackages = Package.where(type_id: 6)
  end

  def horses
  end

  def studs
  end

  def trailers
  end

  def tacks
  end

  def real_estates
  end


end

