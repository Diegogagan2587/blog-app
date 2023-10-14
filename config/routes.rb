Rails.application.routes.draw do
  devise_for :users , controllers: { registrations: 'registrations' }
  root 'users#index'
  resources :users, only: [:index, :show]  do

    resources :posts, only: [:index, :show, :new, :create, :destroy ] do 
      post 'add_like', on: :member
      delete 'delete_like', on: :member
      delete 'delete_post', on: :member
      resources :comments, only: [:new, :create]
    end
  end
end


