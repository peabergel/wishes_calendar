class Event < ApplicationRecord
  belongs_to :calendar
  has_one :event_movie
  has_one :movie, through: :event_movie
end

