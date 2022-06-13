class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order(:release_date)
    @events = Event.where(calendar: current_user.calendar)
    @events_movies = @events.map(&:movie)
  end

  def show
    @movie = Movie.find(params[:id])
    @genres = @movie.genres.map(&:name)
    @events = Event.where(calendar: current_user.calendar)
    @events_movies = @events.map(&:movie)
  end
end
