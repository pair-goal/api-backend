Rails.application.routes.draw do
  post '/user/signup' => 'user#create'
  post '/user/signin' => 'user#new'
  get '/user/profile' => 'user#show'
  put '/user/profile' => 'user#update'
end
