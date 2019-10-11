Rails.application.routes.draw do
  get 'static_controller/home'

  get 'static_controller/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#hello'
end
