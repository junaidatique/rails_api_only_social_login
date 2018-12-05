Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api, defaults: { format: 'json' } do    
    namespace :v1 do 
      
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
      get 'partner/signup/:partner_platform', to: 'partners#signup', as: 'partner_signup'
      get 'partner/autherize/:partner_platform', to: 'partners#autherize', as: 'partner_autherize'

      #webhooks
        # collections
      get 'webhook/collections_create/:service_platform', to: 'webhooks#collections_create', as: 'webhooks_collections_create'
      get 'webhook/collections_delete/:service_platform', to: 'webhooks#collections_delete', as: 'webhooks_collections_delete'
      get 'webhook/collections_update/:service_platform', to: 'webhooks#collections_update', as: 'webhooks_collections_update'
        # products
      get 'webhook/products_create/:service_platform', to: 'webhooks#products_create', as: 'webhooks_products_create'
      get 'webhook/products_delete/:service_platform', to: 'webhooks#products_delete', as: 'webhooks_products_delete'
      get 'webhook/products_update/:service_platform', to: 'webhooks#products_update', as: 'webhooks_products_update'
        # shop
      get 'webhook/app_uninstalled/:service_platform', to: 'webhooks#app_uninstalled', as: 'webhooks_app_uninstalled'
      get 'webhook/shop_update/:service_platform', to: 'webhooks#shop_update', as: 'webhooks_shop_update'
    end
  end
end
