Rails.application.routes.draw do
  get '/', to: redirect('/users')
  resources :users, only: [:index, :show]  do
    resources :posts, only: [:index, :show, :new, :create] do 
      resources :comments, only: [:new, :create]
    end
  end
end


