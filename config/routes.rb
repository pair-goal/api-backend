Rails.application.routes.draw do
  post '/user/signup' => 'user#create'
  post '/user/signin' => 'user#new'
  get '/user/profile' => 'user#show'
  put '/user/profile' => 'user#update'

  get '/goal' => 'goal#index'
  post '/goal' => 'goal#create'
  get '/goal/:id' => 'goal#show'
  put '/goal/:id' => 'goal#update'
  delete '/goal/:id' => 'goal#destroy'
end
