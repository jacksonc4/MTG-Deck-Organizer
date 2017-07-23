Rails.application.routes.draw do
  devise_for :users
  resources :decks do
    resources :comments
  end
  root 'decks#index'
end
