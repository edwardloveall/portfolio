Rails.application.routes.draw do
  root to: 'projects#index'
  resources :projects, only: [:index, :show]
  namespace :admin do
    resources :projects, except: [:show]
  end
  get '/about' => 'high_voltage/pages#show', id: 'about'
end
