Rails.application.routes.draw do

  resource :horses, :only => :create

  get 'subregion_options' => 'ads#subregion_options'

 
  get 'pricing' => 'ads#pricing', :as => :pricing

  get 'place/horse/:id' => 'ads#horse', :as => :place_horse
  get 'place/stud/:id'  => 'ads#stud', :as => :place_stud
  get 'place/trailer/:id'  => 'ads#trailer', :as => :place_trailer
  get 'place/tack/:id'  => 'ads#tack', :as => :place_tack
  get 'place/real_estate/:id'  => 'ads#real_estate', :as => :place_real_estate
  get 'place/service/:id'  => 'ads#service', :as => :place_service
 
  get 'search-studs' => 'search#studs', :as => :search_studs
  get 'search-services' => 'search#services', :as => :search_services
  get 'search-real-estates' => 'search#real_estates', :as => :search_real_estates
  get 'search-tacks' => 'search#tacks', :as => :search_tacks
  get 'search-trailers' => 'search#trailers', :as => :search_trailers
  get 'search-horses' => 'search#horses', :as => :search_horses

  get 'dashboard' => 'dashboard#index', :as => :dashboard
  get 'dashboard/ads' => 'dashboard#ads', :as => :my_ads
  get 'account' => 'dashboard#edit', :as => :account
  patch 'profile/update' => 'dashboard#update', :as => :profile

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  root 'home#index'

  resources :ads do
    member do
      put "like", to: "ads#like"
      put "dislike", to: "ads#dislike"
    end
  end

  resources :packages do
    resources :horses, shallow: true do
      member do 
        get 'preview', to: "horses#preview"
        get 'publish', to: "horses#publish"
      end
    end
  end

  resources :packages do
    resources :studs, shallow: true do
      member do
        get 'preview', to: "studs#preview"
        get 'publish', to: "studs#publish"
      end
    end
  end

  
  resources :packages do
    resources :trailers, shallow: true do
      member do 
        get 'preview', to: "studs#preview"
        get 'publish', to: "studs#publish"
      end
    end
  end

  resources :packages do
    resources :tacks, shallow: true do
      member do 
        get 'preview', to: "tacks#preview"
        get 'publish', to: "tacks#publish"
      end
    end
  end

  resources :packages do
    resources :real_estates, shallow: true do
      member do 
        get 'preview', to: "real_estates#preview"
        get 'publish', to: "real_estates#publish"
      end
    end
  end

  resources :packages do
    resources :services, shallow: true do
      member do 
        get 'preview', to: "services#preview"
        get 'publish', to: "services#publish"
      end
    end
  end

  
end
