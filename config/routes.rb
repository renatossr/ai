Rails.application.routes.draw do
  resources :entries
  resources :statements
  resources :companies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'companies#index'
end
