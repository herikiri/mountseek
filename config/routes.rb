Rails.application.routes.draw do


  resources :horses do 
    collection do
      get 'search'
    end
  end

  resource :studs do 
    collection do
      get 'search'
    end
  end

 
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

  resources :users do
    resources :horses do
      member do
        get "like"
        get "dislike"
      end
    end
  end
  

  resources :profiles do
    member do
      get 'ads'
      get 'about'
      get 'favorites'
    end
    collection do
      get 'ads'
      get 'about'
      get 'favorites'
    end
  end


  get 'pricing' => 'home#pricing', :as => :pricing
  get 'search-horses' => 'home#horses', as: :home_horses
  get 'search-studs' => 'home#studs', as: :home_studs
  get 'search-tacks' => 'home#tacks', as: :home_tacks
  get 'search-real-estates' => 'home#real_estates', as: :home_real_estates
  get 'search-services' => 'home#services', as: :home_services
  get 'search-trailers' => 'home#trailers', as: :home_trailers


end
