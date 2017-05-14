Rails.application.routes.draw do
  get 'static_pages/employee'

  get 'static_pages/project'

  resources :projects
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
