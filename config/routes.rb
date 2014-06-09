Rails.application.routes.draw do

  resources :services

  resources :tacks

  resource :horses, :only => :create

  get 'subregion_options' => 'ads#subregion_options'
  get 'pricing' => 'ads#pricing', :as => :pricing

 
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

  items = %w( horses studs trailers tacks real_estates services )

 
  resources :packages do
    items.each do |item|
      resources item.to_sym, shallow: true do
        member do
          get 'preview', to: "#{item}#preview"
          get 'publish', to: "#{item}#publish"
        end
      end
    end
  end

  resources :ads do
    member do
      put "like", to: "ads#like"
      put "dislike", to: "ads#dislike"
    end
  end

  get 'horses/search' => 'index#search_horses_result'
  
end
