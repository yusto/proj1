Rails.application.routes.draw do
  root to: 'home#index'
  delete 'delete', to: 'pokemon#destroy', as: 'release'
  get 'pokemon/new', to: 'pokemon#new', as: 'new_pokemon'
  patch 'damage', to: 'pokemon#damage', as: 'damage'
  patch 'capture', to: 'pokemon#capture', as: 'capture'
  patch 'heal', to: 'pokemon#heal', as: 'heal'
  post 'create', to: 'pokemon#create', as: 'create'
  devise_for :trainers
  resources :trainers
end
