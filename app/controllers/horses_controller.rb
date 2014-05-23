class HorsesController < ApplicationController

  def create
  	
  	@horse = Horse.new(horse_params)

    if @horse.save
    	render :text => "<h1>Save Horse Success</h1></p>"

    	# redirect to preview ad
      
    else
      render :text => "<h1>Save Horse Failed</h1></p>"
    end
  end

  private 
  	def horse_params
      params.require(:horse).permit(:title, :description, :zip_code, :city, :state, :price, :private_treaty, :ad_for, :name, :gender, :breed, :birth, :color, :height, :weight)
    end


end