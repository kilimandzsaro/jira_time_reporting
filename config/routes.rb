Rails.application.routes.draw do
  devise_for :user, :controllers => {
    :registrations => "user/registrations",
    :sessions => "user/sessions",
    :passwords => "user/passwords",
    :confirmations => "user/confirmations"
  }
    
  devise_scope :user do
    get 'signup', to: "user/registrations#new"
    get 'signin', to: "user/sessions#new"
    delete 'signout', to: "user/sessions#destroy"
  end
  
  resources :businesses
  resources :componenets
  resources :users
  get 'static_pages/employee'

  get 'static_pages/project'

  resources :projects
  resources :employees
  
  root 'employees#index'
end
