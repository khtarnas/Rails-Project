Rails.application.routes.draw do
  root to: 'pages#home'
  
  get '/users/:user/:bool' => 'users#change_status', as: :change_user_status

  resources :friendships #only create and destroy?
  
  resources :posts do
    resources :comments
  end
  
  devise_for :users, :paths => 'users' #need the " :paths => 'users' "?

  resources :users, only: [:show, :index] do
    resource :home
  end
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
