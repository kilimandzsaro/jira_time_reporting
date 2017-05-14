Rails.application.routes.draw do
  get 'static_pages/employee'

  get 'static_pages/project'

  resources :projects
  resources :employees
  
  root 'employees#index'
end
