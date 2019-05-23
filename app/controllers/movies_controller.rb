class MoviesController < ApplicationController
  def index
    @movies = ["Avengers", "Infinity War", "Endgame"]
  end
end
