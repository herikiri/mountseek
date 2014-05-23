class PlaceController < ApplicationController
	before_action :set_package

  def horse
  	@ad_horse = @package.horses.new
  end

  def stud
  end

  def trailer
  end

  def tack
  end

  def real_estate
  end

  def service
  end

  def preview

  end

  private 
  	def set_package
  		@package = Package.find(params[:id])
  	end
end
