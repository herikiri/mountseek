Rails.application.routes.draw do

 
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  root 'home#index'

  items = %w( horses studs trailers tacks real_estates services )
 
  items.each do |item|
    resources item.to_sym do
      collection do
        get 'search'
      end
      member do
        get 'search'
      end
    end
  end
 
  resources :packages do
    items.each do |item|
      resources item.to_sym, shallow: true do
        member do
          get 'preview', to: "#{item}#preview"
          get 'publish', to: "#{item}#publish"
          get 'unpublish', to: "#{item}#unpublish"
          get 'sold', to: "#{item}#sold"
          get 'activate', to: "#{item}#activate"
          get 'unactivate', to: "#{item}#unactivate"
          get 'mark-sold', to: "#{item}#mark_sold"
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

  get 'horses-result' => 'home#horses_result', as: :horses_result
  get 'horses-filter' => 'home#horses_filter', as: :horses_filter

  get 'studs-result' => 'home#studs_result', as: :studs_result
  get 'studs-filter' => 'home#studs_filter', as: :studs_filter

  get 'trailers-result' => 'home#trailers_result', as: :trailers_result
  get 'trailers-filter' => 'home#trailers_filter', as: :trailers_filter

  get 'tacks-result' => 'home#tacks_result', as: :tacks_result
  get 'tacks-filter' => 'home#tacks_filter', as: :tacks_filter

  get 'real_estates-result' => 'home#real_estates_result', as: :real_estates_result
  get 'real_estates-filter' => 'home#real_estates_filter', as: :real_estates_filter


end
