Rails.application.routes.draw do
  root 'activities#statistics'
  resources :activities
end
