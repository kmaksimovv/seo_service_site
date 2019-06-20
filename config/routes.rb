Rails.application.routes.draw do
  devise_for :users
  root to: 'sites#index'

  resources :sites do
    resources :sitemap_files, shallow: true do
      resources :pages, shallow: true
    end
  end
end
