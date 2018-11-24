Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api, defaults: { format: 'json' } do    
    namespace :v1 do 
      get 'partner/signup/:partner_platform', to: 'partners#signup', as: 'partner_signup'
      get 'partner/autherize/:partner_platform', to: 'partners#autherize', as: 'partner_autherize'
      devise_for :users
      resources :users, only: [:show] do
        collection do
          get 'me'
        end
      end
      resources :stores, only: [:show] do 
        resources :profiles, only: [:index] do
          collection do
            get 'connected'
            put 'connect'
          end
          member do
            delete 'disconnect'
          end
        end
      end
      get 'oauth/redirect/:store_id/:service_platform', to: 'oauth#redirect', as: 'oauth_redirect'
      get 'oauth/:service_platform', to: 'oauth#autherize', as: 'oauth_autherize'
    end
  end
end
