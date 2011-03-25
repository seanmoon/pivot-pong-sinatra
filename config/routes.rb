Pong::Application.routes.draw do
  resources :matches
  root to: 'matches#index'
end
