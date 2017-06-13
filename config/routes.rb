Rails.application.routes.draw do

  resources :appointments, only: [:show, :index, :new, :create, :edit, :update, :destroy] do
    #resources :doses, only: [:new, :create]
  end
  resources :artworks do
      resources :appointments, only: [:new,:create]
  end

  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, controller: "profile", only: [:edit, :update, :show]

  # Do you really need this one???
  get "homepage" , to: "pages#home"

  root to: "pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :artworks
end
