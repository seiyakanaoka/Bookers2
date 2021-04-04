Rails.application.routes.draw do

  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }
  
  get 'homes/top'
  get 'mypage', to: 'homes#mypage'
  
  
  get 'search/search'
  root 'home#top'
  get 'home/about'
  
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
