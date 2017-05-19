Rails.application.routes.draw do
  devise_for :users, :controllert => { :passwords => "users/passwords", :confirmations => "users/confirmations" }
  devise_scope :users do
    get 'signup', to: "devise/registrations#new"
    get 'signin', to: "devise/sessions#new"
    delete 'signout', to: "devise/sessions#destroy"
  end
  resources :businesses
  resources :componenets
  get 'static_pages/employee'

  get 'static_pages/project'

  resources :projects
  resources :employees
  
  root 'employees#index'
end
