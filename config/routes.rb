Rails.application.routes.draw do

  resources :show_results
  resources :overtimes, :except => [:index, :edit, :show, :new]
  resources :vacations, :except => [:index, :edit, :show, :new]
  resources :report_results, :except => [:edit, :show, :destroy]
  resources :global_settings do
    collection do
      get :get, to: "global_settings#get"
    end
  end
  resources :issues
  resources :issue_histories
  resources :businesses, :except => [:show, :destroy, :create, :new]

  resources :report_types
  resources :components, :except => [:edit, :show, :update, :destroy, :new] 
  resources :projects, :except => [:show]

  resources :statuses, :except => [:show] do
    collection do
      get :refresh, to: "statuses#refresh"
    end
  end
  
  resources :reports do 
    get :get_report, to: "reports#get_report"
    get :get_results, to: "reports#get_results"
  end
  get 'reports/index'

  resources :employees, :except => [:destroy, :create, :new] do
    get :hide_and_show
    collection do
      get :refresh, to: "employees#refresh"
    end
  end

  devise_for :users, :controllers => {
    :registrations => "users/registrations",
    :sessions => "users/sessions",
    :passwords => "users/passwords",
    :confirmations => "users/confirmations",
    :unlocks => "users/unlocks",
    :omniauth => "users/omniauth"
  } 

  devise_scope :user do
    # get 'signup', to: "users/registrations#new"
    # get 'signin', to: "users/sessions#new"
    get 'users/sign_out', to: "users/sessions#destroy"
  end

  resources :users
    
  root 'reports#index'
end
