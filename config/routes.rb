Rails.application.routes.draw do
  root to: 'movies#index'
  get 'movies', to: 'movies#index'
  get 'movies/:id', to: 'movies#show', as: 'movie'
end
