Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get ':fecha1/:fecha2', to: 'posts#fecha_a_fecha'
    end
  end
  namespace :api do
    namespace :v1 do
      get 'news', to: 'posts#news'
    end
  end
  namespace :api do
    namespace :v1 do
      post 'posts/create', to: 'posts#create'
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'users/index'
  resources :posts
  devise_for :users
  root 'posts#index'
  post 'posts/create'
  post 'posts/repost/:id', to: 'posts#repost', as: 'repost'
  get 'likes/:id', to: 'likes#to_like', as: 'like'
  delete 'likes/:id', to: 'likes#to_dislike', as: 'dislike'
  post 'follows/:id', to: 'follows#to_follow', as: 'follow'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
