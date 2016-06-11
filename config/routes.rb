Rails.application.routes.draw do

  resources :emergencies, except: [:show, :update]
  resources :responders, except: [:show, :update]

  patch '/emergencies/:code' => 'emergencies#update'
  get '/emergencies/:code' => 'emergencies#show'

  patch '/responders/:name  ' => 'responders#update'
  get '/responders/:name  ' => 'responders#show'

end
