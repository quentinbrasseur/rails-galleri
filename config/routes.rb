Rails.application.routes.draw do

  resources :appointments, only: [:show, :index, :new, :create, :edit, :update, :destroy] do
    #resources :doses, only: [:new, :create]
  end


  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  get "homepage" , to: "pages#home"

  root to: "pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :artworks
end
