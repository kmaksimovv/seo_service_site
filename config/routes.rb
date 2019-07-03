require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end
  
  devise_for :users
  root to: 'sites#index'

  resources :sites do
    resource :sitemap_file, only: :show, shallow: true 
  end

  get :robot, to: 'robots#robot', as: :robot_txt
  get :parsing_page, to: 'parsing_pages#parsing_page'
end
