Rails.application.routes.draw do
  get '/', to: redirect('/users')
  resources :users, only: [:index, :show]  do
    resources :posts, only: [:index, :show, :new]
  end
end


