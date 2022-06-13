class Movie < ApplicationRecord
  has_many :genre_movies
  has_many :genres, through: :genre_movies
  has_many :events, through: :event_movies

end