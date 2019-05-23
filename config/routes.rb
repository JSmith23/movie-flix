Rails.application.routes.draw do
  get 'movie/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'movies', to: 'movies#index'
end
