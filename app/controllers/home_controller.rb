class HomeController < ApplicationController

  before_action :set_search_horses, only: [:horses, :horses_result, :horses_filter]
  before_action :set_search_studs, only: [:studs, :studs_result, :studs_filter]

  before_action :set_search_horses_result, only: [:horses_result, :horses_filter]
  before_action :set_search_studs_result, only: [:studs_result, :studs_filter]

  before_action :set_breed_options, only: [:horses , :studs]
  before_action :set_state_options, only: [:horses , :studs]
  before_action :set_gender_options, only: [:horses]
  before_action :set_ai_type_options, only: [:studs]

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


  def horses_result
    
  end

  def horses_filter
  end


  def studs_result
   
  end

  def studs_filter
  end

  private 
    def set_search_horses
      @search_horses = Horse.search(params[:q])
    end

    def set_search_studs
      @search_studs = Stud.search(params[:q])
    end

    def set_search_horses_result
      if params[:q] 
        @horses = @search_horses.result
      else
        @horses = nil;
      end
    end

    def set_search_studs_result
      if params[:q] 
        @studs = @search_studs.result
      else
        @studs = nil;
      end
    end

    def set_breed_options
      @breeds = BreedOption.all.order(name: :asc)
    end

    def set_gender_options
      @genders = GenderOption.all.order(name: :asc)
    end

    def set_ai_type_options
      @ai_types = AiTypeOption.all.order(name: :asc)
    end

    def set_state_options
      @states = StateOption.all.order(name: :asc)
    end

end

