Rails.application.routes.draw do

  get 'studs' => 'studs#index', via: [:get, :post], :as => :studs
  get 'services' => 'services#index', via: [:get, :post], :as => :services
  get 'real_estates' => 'real_estates#index', via: [:get, :post], :as => :real_estates
  get 'tacks' => 'tacks#index', via: [:get, :post], :as => :tacks
  get 'trailers' => 'trailers#index', via: [:get, :post], :as => :trailers
  get 'horses' => 'horses#index', via: [:get, :post], :as => :horses

  get 'dashboard' => 'dashboard#index', via: [:get, :post], :as => :dashboard

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  root 'home#index'
end
