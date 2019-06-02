# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'sites#index'

  resources :sites
  devise_for :users
end
