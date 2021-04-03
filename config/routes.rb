Rails.application.routes.draw do
  get 'search/search'
  root 'home#top'
  get 'home/about'
  devise_for :users
  resources :books, only: [:index, :show, :edit, :create, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    member do
        get :follow, :follower
      end
    resource :relationships, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
