Rails.application.routes.draw do
  root 'cards#index'
  resources :cards, only:[:index, :show]
  resources :contacts, only:[:create]
end
