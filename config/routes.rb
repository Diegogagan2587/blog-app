Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show]  do
    resources :posts, only: [:index, :show, :new, :create] do 
      post 'add_like', on: :member
      delete 'delete_like', on: :member
      resources :comments, only: [:new, :create]
    end
  end
end


