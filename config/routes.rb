Rails.application.routes.draw do
  devise_for :users

  resources :projects do
    resources :tasks do
      patch :update_status,   on: :member
      patch :update_priority, on: :member
    end
  end

  root 'projects#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
