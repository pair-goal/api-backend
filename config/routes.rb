Rails.application.routes.draw do
  post '/user/signup' => 'user#create'
  post '/user/signin' => 'user#new'
end
