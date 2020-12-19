Rails.application.routes.draw do
  resources :friendships
  root to: 'pages#home'
  
  resources :posts do
    resources :comments
  end
  
  devise_for :users, :paths => 'users' #need the " :paths => 'users' "?

  resources :users, only: [:show, :index] do
    resource :home
  end
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
