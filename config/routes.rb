Rails.application.routes.draw do

  resource :horses, :only => :create

  get 'horse/:id' => 'ads#show', :as => :horse_ad

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

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  root 'home#index'
end
