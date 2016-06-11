Rails.application.routes.draw do

  resources :emergencies, except: [:show, :update]
end
