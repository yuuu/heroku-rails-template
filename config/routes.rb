# frozen_string_literal: true

Rails.application.routes.draw do
  resources :diaries, except: [:show]
  root to: 'pages#home'
  get 'pages/about'
  get 'pages/help'

  devise_for :users
end
