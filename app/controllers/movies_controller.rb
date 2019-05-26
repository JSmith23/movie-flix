class MoviesController < ApplicationController
  def index
    @movies = Movie.all 
  end

  def show
    @movie = Movie.find(params[:id])
  end 

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(permit_params)
    redirect_to movie_path(@movie)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(permit_params)
    @movie.save
    redirect_to movie_path(@movie)
  end

  private

  def permit_params
    params.require(:movie).permit(:title, :rating, :total_gross, :description, :released_on) 
  end

end
