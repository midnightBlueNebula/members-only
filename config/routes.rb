Rails.application.routes.draw do

  get 'comments/new'
  get 'posts/new'
  root   'home_page#home'
  
  get    '/signup'        , to: 'users#new'
  post   '/signup'        , to: 'users#create'
  get    '/users'         , to: 'users#index'
  get    '/users/:id'     , to: 'users#show'
  get    '/users/:id/edit', to: 'users#edit'
  post   '/users/:id'     , to: 'users#update'
  delete '/users/:id'     , to: 'users#destroy'

  get    '/login'         , to: 'sessions#new'
  post   '/login'         , to: 'sessions#create'
  delete '/logout'        , to: 'sessions#destroy'

  resources :users

end
