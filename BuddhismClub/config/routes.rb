Rails.application.routes.draw do

  # Rooted at public home page
  root to: 'pages#home'
  
  # Friend view page
  get 'posts/friends' => 'posts#friends', as: :friends_posts

  # Change to admin method
  get '/users/:user/:bool' => 'users#change_status', as: :change_user_status

  # Methods for user many-to-many relationship
  resources :friendships, only: [:create, :destroy]
  
  # Nested relationship for posts under comments
  resources :posts do
    resources :comments
  end
  
  # Devise routes for user
  devise_for :users, :paths => 'users' #need the " :paths => 'users' "?

  # Nested homes under users
  resources :users, only: [:show, :index] do
    resource :home
  end
end
