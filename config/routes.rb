Rails.application.routes.draw do

  resource :horses, :only => :create

  get 'horse/:id' => 'horses#show', :as => :horse

  patch 'horse/:id' => 'horses#update'
  get 'subregion_options' => 'ads#subregion_options'

  get 'place/horse/:id/edit' => 'ads#edit_horse', :as => :place_horse_edit

  get 'pricing' => 'ads#pricing', :as => :pricing
  get 'preview/:id' => 'ads#preview', :as => :preview_ad
  get 'publish/:id' => 'ads#publish', :as => :publish_ad
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

  resources :ads, except: [:new] do
    member do
      put "like", to: "ads#like"
      put "dislike", to: "ads#dislike"
    end
  end

  resources :trailer do
    resources :ads
  end
  
end
