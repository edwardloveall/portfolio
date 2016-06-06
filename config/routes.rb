Rails.application.routes.draw do
  root to: 'projects#index'
  resources :projects, only: [:index, :show]
  resources :music, controller: :songs, only: [:index, :show], as: :songs
  get 'experiments', to: 'experiments#index'
  get 'experiments/*path', to: 'experiments#show'

  namespace :admin do
    resources :projects, except: [:show]
    resources :songs, except: [:show]
  end
  get '/about' => 'high_voltage/pages#show', id: 'about'
end
