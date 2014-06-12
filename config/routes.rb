Rails.application.routes.draw do

  get 'subregion_options' => 'ads#subregion_options'
  get 'pricing' => 'home#pricing', :as => :pricing

  resource :horses do 
    collection do
      get 'search'
    end
  end

  resource :studs do 
    collection do
      get 'search'
    end
  end

 
  get 'search-studs' => 'home#studs'
  get 'search-services' => 'search#services', :as => :search_services
  get 'search-real-estates' => 'search#real_estates', :as => :search_real_estates
  get 'search-tacks' => 'search#tacks', :as => :search_tacks
  get 'search-trailers' => 'search#trailers'
  get 'search-horses' => 'home#horses'

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
          get 'activate', to: "#{item}#activate"
          get "like", to: "#{item}#like"
          get "dislike", to: "#{item}#dislike"
        end
      end
    end
  end


end
