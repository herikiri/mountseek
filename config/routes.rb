Rails.application.routes.draw do

  resource :horses, :only => :create

  get 'preview/:id' => 'place#preview', via: [:get, :post], :as => :preview_ad

  get 'place/horse/:id' => 'place#horse', via: [:get, :post], :as => :place_horse
  get 'place/stud/:id'  => 'place#stud', via: [:get, :post], :as => :place_stud
  get 'place/trailer/:id'  => 'place#trailer', via: [:get, :post], :as => :place_trailer
  get 'place/tack/:id'  => 'place#tack', via: [:get, :post], :as => :place_tack
  get 'place/real_estate/:id'  => 'place#real_estate', via: [:get, :post], :as => :place_real_estate
  get 'place/service/:id'  => 'place#service', via: [:get, :post], :as => :place_service



  get 'pricing' => 'pricing#index', via: [:get, :post], :as => :pricing
  
  get 'search-studs' => 'nav_studs#index', via: [:get, :post], :as => :search_studs
  get 'search-services' => 'nav_services#index', via: [:get, :post], :as => :search_services
  get 'search-real-estates' => 'nav_real_estates#index', via: [:get, :post], :as => :search_real_estates
  get 'search-tacks' => 'nav_tacks#index', via: [:get, :post], :as => :search_tacks
  get 'search-trailers' => 'nav_trailers#index', via: [:get, :post], :as => :search_trailers
  get 'search-horses' => 'nav_horses#index', via: [:get, :post], :as => :search_horses

  get 'dashboard' => 'dashboard#index', via: [:get, :post], :as => :dashboard

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  root 'home#index'
end
