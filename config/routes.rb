Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do 
      devise_for :users
      resources :users, only: [:show]
      get 'oauth/redirect/:store_id/:service_platform', to: 'oauth#redirect', as: 'oauth_redirect'
      get 'oauth/:service_platform', to: 'oauth#autherize', as: 'oauth_autherize'
    end
  end
end
