Rails.application.routes.draw do
  root to: "pages#home"


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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "search", to: 'artworks#search'
end

