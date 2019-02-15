Rails.application.routes.draw do
  resources :diaries
  root to: 'pages#home'
  get 'pages/about'
  get 'pages/help'

  devise_for :users
end
