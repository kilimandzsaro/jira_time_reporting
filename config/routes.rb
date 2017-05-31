Rails.application.routes.draw do
  resources :global_settings
  resources :statuses, :except => [:show, :edit, :update] do
    collection do
      get :refresh, to: "statuses#refresh"
    end
  end
  resources :issues
  resources :report_types, :except => [:show, :edit]
  resources :reports do
    get :get
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
  resources :projects, :except => [:show]
  resources :employees, :except => [:destroy] do
    get :hide_and_show
  end
  resources :users
  root 'reports#index'
end
