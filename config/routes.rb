Rails.application.routes.draw do
  resources :projects do
    resources :tasks do
      patch :update_status,   on: :member
      patch :update_priority, on: :member
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
