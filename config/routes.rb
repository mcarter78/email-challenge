Rails.application.routes.draw do
  post '/api/login', to: 'users#login'
  get '/api/users', to: 'users#index'
  post '/api/users', to: 'users#create'
  get '/api/users/:id', to: 'users#show'
  get '/api/users/:id/edit', to: 'users#edit'
  put '/api/users/:id', to: 'users#update'
  delete '/api/users/:id', to: 'users#destroy'
end
