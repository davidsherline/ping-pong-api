Rails.application.routes.draw do
  resources :players, except: [:destroy]
end
