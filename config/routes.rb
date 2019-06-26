require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users
  root to: 'sites#index'

  resources :sites do
    resource :sitemap_file, only: :show, shallow: true do
      resources :pages, only: [:index], shallow: true
    end
  end
end
