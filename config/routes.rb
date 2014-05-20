Rails.application.routes.draw do

  get 'dashboard/index'

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  root 'home#index'
end
