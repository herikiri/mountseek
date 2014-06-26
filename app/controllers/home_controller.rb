class HomeController < ApplicationController

  before_action :set_search_horses, only: [:horses, :horses_result, :horses_filter]
  before_action :set_search_studs, only: [:studs, :studs_result, :studs_filter]
  before_action :set_search_trailers, only: [:trailers, :trailers_result, :trailers_filter]
  before_action :set_search_tacks, only: [:tacks, :tacks_result, :tacks_filter]
  before_action :set_search_real_estates, only: [:real_estates, :real_estates_result, :real_estates_filter]
  before_action :set_search_services, only: [:services, :services_result, :services_filter]

  before_action :set_search_horses_result, only: [:horses_result, :horses_filter]
  before_action :set_search_studs_result, only: [:studs_result, :studs_filter]
  before_action :set_search_tacks_result, only: [:tacks_result, :tacks_filter]
  before_action :set_search_trailers_result, only: [:trailers_result, :trailers_filter]
  before_action :set_search_real_estates_result, only: [:real_estates_result, :real_estates_filter]
  before_action :set_search_services_result, only: [:services_result, :services_filter]

  before_action :set_breed_options, only: [:horses , :studs]
  before_action :set_state_options, only: [:horses , :studs, :trailers, :real_estates, :services]


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
    @genders = GenderOption.all.order(name: :asc)
  end

  def studs
    @ai_types = AiTypeOption.all.order(name: :asc)
  end

  def trailers
    @hauls = Trailer.all.map(&:hauls).uniq
  end

  def tacks
    @tack_categories = TackOption.all.order(name: :asc)
    @tacks_type = TackTypeOption.all.order(name: :asc)
    @conditions = ConditionOption.all.order(name: :asc)
  end

  def real_estates
    @house_types = HouseTypeOption.all.order(name: :asc)
    @bedrooms = RealEstate.all.map(&:bedroom).uniq.sort()
  end

  def services
    @service_types = ServiceTypeOption.all.order(name: :asc)
  end

  def horses_result
  end

  def horses_filter
  end

  def studs_result
  end

  def studs_filter
  end

  def trailers_result
  end

  def trailers_filter
  end

  def tacks_result
  end

  def tacks_filter
  end

  def real_estates_result
  end

  def real_estates_filter
  end

  def services_result
  end

  def services_filter
  end

  private 
    def set_search_horses
      @search_horses = Horse.search(params[:q])
    end

    def set_search_studs
      @search_studs = Stud.search(params[:q])
    end

    def set_search_trailers
      @search_trailers = Trailer.search(params[:q]) 
    end

    def set_search_tacks
      @search_tacks = Tack.search(params[:q])
    end

    def set_search_real_estates
      @search_real_estates = RealEstate.search(params[:q])
    end

    def set_search_services
      @search_services = Service.search(params[:q])
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

    def set_search_trailers_result
      if params[:q] 
        @trailers = @search_trailers.result
      else
        @trailers = nil;
      end
    end

    def set_search_tacks_result
      if params[:q] 
        @tacks = @search_tacks.result
      else
        @tacks = nil;
      end
    end

    def set_search_real_estates_result
      if params[:q] 
        @real_estates = @search_real_estates.result
      else
        @real_estates = nil;
      end
    end

    def set_search_services_result
      if params[:q] 
        @services = @search_services.result
      else
        @services = nil;
      end
    end

    def set_breed_options
      @breeds = BreedOption.all.order(name: :asc)
    end

    def set_state_options
      @states = StateOption.all.order(name: :asc)
    end


end

