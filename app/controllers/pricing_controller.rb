class PricingController < ApplicationController
  def index
  	@horsePackages = Package.where(type_id: 1)
  	@studPackages = Package.where(type_id: 2)
  	@trailerPackages = Package.where(type_id: 3)
  	@tackPackages = Package.where(type_id: 4)
  	@realEstatePackages = Package.where(type_id: 5)
  	@servicePackages = Package.where(type_id: 6)
  end
end
