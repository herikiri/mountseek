class HomeController < ApplicationController

   before_action :reset_breed_options, only: [:horses, :studs]

   before_action :reset_gender_options, only: [:horses]
   before_action :reset_ai_type_options, only: [:studs]

   before_action :reset_state_options, only: [:horses, :studs]

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
    @search_horses = Horse.search(params[:q])

    @horses = @search_horses.result
    puts "************************"
    puts params[:q]
    puts "#{@horses.count} size"
    puts "************************"
  end

  def studs
    @search_studs = Stud.search(params[:q])
    
    @studs = @search_studs.result

    puts "************************"
    puts params[:q]
    puts "#{@studs.count} size"
    puts "************************"
  end

  def trailers
  end

  def tacks
  end

  def real_estates
  end

  private
    def reset_breed_options
      BreedOption.update_all(checked: false)

      if params[:q]
        BreedOption.where(name: params[:q][:breed_cont_any]).update_all(checked: true)
      end
     
      @breeds = BreedOption.all.order(name: :asc)
    end

    def reset_gender_options
      GenderOption.update_all(checked: false)

      if params[:q]
        GenderOption.where(name: params[:q][:gender_cont_any]).update_all(checked: true)
      end

      @genders = GenderOption.all.order(name: :asc)
    end

    def reset_ai_type_options
      AiTypeOption.update_all(checked: false)

      if params[:q]
        AiTypeOption.where(name: params[:q][:ai_type_cont_any]).update_all(checked: true)
      end
     
      @ai_types = AiTypeOption.all.order(name: :asc)
    end

    def reset_state_options
      StateOption.update_all(checked: false)

      if params[:q]
        StateOption.where(name: params[:q][:state_cont_any]).update_all(checked: true)
      end

      @states = StateOption.all.order(name: :asc)
    end

end

