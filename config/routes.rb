Rails.application.routes.draw do

  resources :emergencies, except: [:show, :update]
  resources :responders, except: [:show, :update]

  patch '/emergencies/:code' => 'emergencies#update'

end
