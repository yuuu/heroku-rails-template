# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'pages#home'

  get 'pages/about'
  get 'pages/help'

  resources :diaries, except: [:show]
  resources :imports, only: [:new, :create]

  devise_for :users
end
