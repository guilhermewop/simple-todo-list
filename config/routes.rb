Rails.application.routes.draw do
  # root 'index#index'
  devise_for :users

  # get 'index/index'
  # resources :index

  root to: 'tasks#index'

  resources :tasks do
    member do
      patch :completed, to: "tasks#completed"
      patch :privacy, to: "tasks#privacy"
    end
    resources :subtasks do
      member do
        patch :completed, to: "subtasks#completed"
        delete :destroy, to: "subtasks#destroy", as: "destroy"
      end
    end
  end
end
