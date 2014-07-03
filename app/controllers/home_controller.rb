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

  before_action :set_breed_options, only: [:horses, :horses_result, :studs, :studs_result]
  before_action :set_gender_options, only: [:horses, :horses_result]
  before_action :set_state_options, only: [:horses , :horses_result, :studs, :studs_result, :trailers, :trailers_result, :real_estates, :real_estates_result, :services, :services_result]
  before_action :set_ai_type_options, only: [:studs, :studs_result]
  before_action :set_hauls_options, only: [:trailers, :trailers_result]
  before_action :set_tacks_options, only: [:tacks, :tacks_result]
  before_action :set_house_options, only: [:real_estates, :real_estates_result]
  before_action :set_service_options, only: [:services, :services_result]

  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

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

  def services
  end

  def horses_result
    smart_listing_create(:horses, @horses, partial: "home/horses/horse_list")
    if params[:q]
      gon.params_value = params[:q][:breed_cont_any] if params[:q][:breed_cont_any]
      gon.params_value += params[:q][:gender_cont_any] if params[:q][:gender_cont_any]
      gon.params_value += params[:q][:state_cont_any] if params[:q][:state_cont_any]
    end
  end

  def studs_result
    smart_listing_create(:studs, @studs, partial: "home/studs/stud_list")
    if params[:q]
      gon.params_value = params[:q][:breed_cont_any] if params[:q][:breed_cont_any]
      gon.params_value += params[:q][:ai_type_cont_any] if params[:q][:ai_type_cont_any]
      gon.params_value += params[:q][:state_cont_any] if params[:q][:state_cont_any]
    end
  end

  def trailers_result
    smart_listing_create(:trailers, @trailers, partial: "home/trailers/trailer_list")
    if params[:q]
      gon.params_value = params[:q][:hauls_eq_any] if params[:q][:hauls_eq_any]
      gon.params_value += params[:q][:state_cont_any] if params[:q][:state_cont_any]
    end
  end

  def tacks_result
    smart_listing_create(:tacks, @tacks, partial: "home/tacks/tack_list")
    if params[:q]
      gon.params_value = params[:q][:tack_cont_any] if params[:q][:tack_cont_any]
      gon.params_value += params[:q][:tack_type_cont_any] if params[:q][:tack_type_cont_any]
      gon.params_value += params[:q][:condition_cont_any] if params[:q][:condition_cont_any]
    end

  end

  def real_estates_result
    smart_listing_create(:real_estates, @real_estates, partial: "home/real_estates/real_estate_list")
    if params[:q]
      gon.params_value = params[:q][:house_type_cont_any] if params[:q][:house_type_cont_any]
      gon.params_value += params[:q][:bedroom_eq_any] if params[:q][:bedroom_eq_any]
      gon.params_value += params[:q][:state_cont_any] if params[:q][:state_cont_any]
    end
  
  end

  def services_result
    smart_listing_create(:services, @services, partial: "home/services/service_list")
    if params[:q]
      gon.params_value = params[:q][:service_type_cont_any] if params[:q][:service_type_cont_any]
      gon.params_value += params[:q][:state_cont_any] if params[:q][:state_cont_any]
    end
  end

  def horses_filter
  end

  def studs_filter
  end

  def trailers_filter
  end

  def tacks_filter
  end

  def real_estates_filter
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
        @horses = Horse.all;
      end
      @horses = @horses.live
    end

    def set_search_studs_result
      if params[:q] 
        @studs = @search_studs.result
      else
        @studs = Stud.all;
      end
      @studs = @studs.live
    end

    def set_search_trailers_result
      if params[:q] 
        @trailers = @search_trailers.result
      else
        @trailers = Trailer.all;
      end
      @trailers = @trailers.live
    end

    def set_search_tacks_result
      if params[:q] 
        @tacks = @search_tacks.result
      else
        @tacks = Tack.all;
      end
      @tacks = @tacks.live
    end

    def set_search_real_estates_result
      if params[:q] 
        @real_estates = @search_real_estates.result
      else
        @real_estates = RealEstate.all;
      end
      @real_estates = @real_estates.live
    end

    def set_search_services_result
      if params[:q] 
        @services = @search_services.result
      else
        @services = Service.all;
      end
      @services = @services.live
    end

    def set_breed_options
      @breeds = BreedOption.all.order(name: :asc)
    end

    def set_gender_options
      @genders = GenderOption.all.order(name: :asc)
    end

    def set_state_options
      @us_states = Carmen::Country.named('United States').subregions
      @ca_states = Carmen::Country.named('Canada').subregions
    end

    def set_ai_type_options
      @ai_types = AiTypeOption.all.order(name: :asc)
    end

    def set_hauls_options
      @hauls = Trailer.all.map(&:hauls).uniq
    end

    def set_tacks_options
      @tack_categories = TackOption.all.order(name: :asc)
      @tacks_type = TackTypeOption.all.order(name: :asc)
      @conditions = ConditionOption.all.order(name: :asc)
    end

    def set_house_options
      @house_types = HouseTypeOption.all.order(name: :asc)
      @bedrooms = RealEstate.all.map(&:bedroom).uniq.sort()
    end

    def set_service_options
      @service_types = ServiceTypeOption.all.order(name: :asc)
    end

end

