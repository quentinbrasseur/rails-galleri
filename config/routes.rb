Rails.application.routes.draw do


  get 'appointments/index'

  get 'appointments/show'

  get 'appointments/new'

  get 'appointments/create'

  get 'appointments/edit'

  get 'appointments/update'

  get 'appointments/destroy'

  devise_for :users

  get "homepage" , to: "pages#home"

  root to: "pages#home"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
