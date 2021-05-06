Rails.application.routes.draw do
  root 'activities#index'
  resources :activities
  get 'statistics', to: 'activities#statistics'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
