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

  get '/goal/:goal_id/diary/:date' => 'diary#show'
  put '/goal/:goal_id/diary/:date' => 'diary#update'

  get '/conversation' => 'conversation#index'
  get '/conversation/:id' => 'conversation#show'
  post '/conversation/:id' => 'conversation#new'
  get '/conversation/message/:id' => 'conversation#message'
end
