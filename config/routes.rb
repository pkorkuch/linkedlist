Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    resources :link_posts, path: 'posts', shallow: true
    resources :bookmarks, only: :index
    collection do
      get 'activate/:activation_token', to: 'users#activate', as: :activate
    end
  end
  resources :bookmarks, only: %i[create destroy]
end
