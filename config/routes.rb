Rails.application.routes.draw do
  root 'application#index'
  resources :users, exclude: [:index]


  resources :songs, exclude: [:index]
  get 'songs/:id/add' => 'playlists#create'


  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
