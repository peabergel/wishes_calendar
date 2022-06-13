class EventsController < ApplicationController
  def index
    @events = Event.where(calendar: current_user.calendar)
    @events_dates = @events.map(&:release_date).uniq.sort
  end

  def create
    @calendar = current_user.calendar
    @movie = Movie.find(params[:movie_id])
    @event = Event.new(calendar: @calendar, release_date: @movie.release_date)
    @event.save!
    EventMovie.create!(movie: @movie, event: @event)
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:release_date)
  end
end
