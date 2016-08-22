Rails.application.routes.draw do
  constraints(subdomain: /blog.*/) do
    get '/', to: 'posts#index'
    get '/:slug', to: 'posts#show', as: :post
    resources :posts, only: [:index]
  end

  root to: 'projects#index'
  resources :projects, only: [:index, :show]
  resources :music, controller: :songs, only: [:index, :show], as: :songs
  get 'experiments', to: 'experiments#index'
  get 'experiments/*path', to: 'experiments#show'

  namespace :admin do
    root to: 'projects#index'
    resource :session, only: [:new, :create, :destroy]
    resources :projects, except: [:show] do
      collection do
        post :sort
      end
    end
    resources :songs, except: [:show] do
      collection do
        post :sort
      end
    end
    resources :posts, except: [:show]
  end

  get '/about' => 'high_voltage/pages#show', id: 'about'
end
