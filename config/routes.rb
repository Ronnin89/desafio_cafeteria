Rails.application.routes.draw do
  resources :drinks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'drinks#graphic'
end
