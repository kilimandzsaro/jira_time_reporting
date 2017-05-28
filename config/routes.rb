Rails.application.routes.draw do
  resources :issues
  resources :report_types, :except => [:show]
  resources :reports do
    collection do
      get :get
    end
  end
  get 'reports/index'

  resources :issue_histories
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
  resources :components, :except => [:edit, :show, :update, :destroy] 
  resources :projects
  resources :employees, :except => [:destroy]
  resources :users
  root 'reports#index'
end
