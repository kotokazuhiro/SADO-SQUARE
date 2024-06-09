Rails.application.routes.draw do
 
  namespace :admin do
    get 'homes/top'
    
    resources :posts, only: [:index, :show]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :destroy]
    resources :comments, only: [:index, :destroy]
  end
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
    
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "users/registrations",
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # post "users/guest_sign_in", to: "sessions#guest_sign_in"
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  namespace :users do
    
    get "search" => "searches#search"
    get '/genre/search' => 'searches#genre_search'
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    
    resources :genres, only: [:index]
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      get :search, on: :collection
      resource :nice, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :users, only: [:index, :show, :edit, :create, :update, :destroy] do
      member do
        get :nices
      end
    end
  end
  
  get 'homes/about'
  root to: "homes#top"
  
end
