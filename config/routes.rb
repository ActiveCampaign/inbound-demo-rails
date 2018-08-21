Rails.application.routes.draw do

  resources :articles, only: [:show]  
  
  root 'articles#index'
  
end
