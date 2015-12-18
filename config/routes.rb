Rails.application.routes.draw do
  resources :projects, only: [:index, :show]
end
