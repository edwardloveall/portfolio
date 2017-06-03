Rails.application.routes.draw do
  constraints(subdomain: /blog.*/) do
    get '/', to: 'posts#index'
    get '/rss', to: 'posts#index', defaults: { format: :rss }
    get '/:slug', to: 'posts#show', as: :post
    resources :posts, only: [:index]
  end

  root to: 'projects#index'
  resources :projects, only: [:index, :show]
  resources :music, controller: :songs, only: [:index, :show], as: :songs
  get 'experiments', to: 'experiments#index'
  get 'experiments/*path', to: 'experiments#show'
  scope :microblog do
    root to: 'microposts#index', as: :microblog
    resources :microposts, only: [:index, :show]
    get '/feed', to: 'microposts#feed', as: :microposts_feed
    get '/posts/:ms_epoch', to: 'microposts#show', as: :micropost_ms_epoch
  end

  namespace :admin do
    root to: 'projects#index', as: :root
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
    resources :microposts, except: [:index, :show]
  end

  namespace :api do
    resources :microposts, only: [:index, :create], defaults: { format: :json }
  end

  get '/about' => 'high_voltage/pages#show', id: 'about'
end
