class SearchController < ApplicationController
	before_action :set_user
  
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

  def services
  end


  private 
  	def set_user
  		@user = current_user
  	end

end
