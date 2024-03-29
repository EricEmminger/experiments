# frozen_string_literal: true

require 'resque/server'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'site#index'
  get 'site/index'
  get 'site/test'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  authenticate :user do
    mount Resque::Server, at: '/jobs'
  end
  resources :bookmarks
  resources :feeds
  resources :items
  namespace :api do
    namespace :v1 do
      resources :bookmarks
      resources :feeds
      resources :items
      resources :profiles
      resources :reactions
      resources :subscriptions
      resources :syndications
      resources :users
    end
  end
end
