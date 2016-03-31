Rails.application.routes.draw do
  root 'index#index'
  devise_for :users

  get 'index/index'
  resources :index

  resources :tasks do
    member do
      patch :completed, to: "tasks#completed"
      patch :privacy, to: "tasks#privacy"
    end
    resources :subtasks
  end
end
