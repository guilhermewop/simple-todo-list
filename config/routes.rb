Rails.application.routes.draw do
  root 'index#index'
  devise_for :users

  get 'index/index'
  resources :index

  resources :tasks do
    resources :subtasks
  end
end
