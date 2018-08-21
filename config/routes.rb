Rails.application.routes.draw do

  resources :articles, only: [:show]
  resources :responses, only: [:create]
  
  root 'articles#index'
  
end
