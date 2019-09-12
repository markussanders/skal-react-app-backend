Rails.application.routes.draw do
  resources :searches
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :drinks
  resources :favorites
  resources :comments

end
