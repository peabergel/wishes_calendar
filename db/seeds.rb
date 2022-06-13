# require 'json'
# require 'open-uri'

# User seed
puts 'Creating user(s).........'
User.create(first_name: 'Pierre-Elie', last_name: 'Abergel', email: 'pe.abergel@gmail.com', password: 'azerty')
User.create(first_name: 'Kevin', last_name: 'Abergel', email: 'k.abergel91@gmail.com', password: 'azerty')
puts 'Success'

# ------------------------------------------------

# Calendar seed
puts 'Creating Calendar...........'
Calendar.create(user: User.first)
Calendar.create(user: User.second)
puts 'Success'

# ------------------------------------------------

# Genre seed
puts 'Creating genres'
genres_url = 'https://api.themoviedb.org/3/genre/movie/list?api_key=37ad0282d6e101d37cc25353577d615f&language=en-US'
genres_serialized = URI.parse(genres_url).open.read
genres = JSON.parse(genres_serialized)['genres']
genres.each do |hash|
  Genre.create(name: hash['name'])
end
puts 'Success'

# --------------------------------------------------

# Movie and GenreMovie seed

puts 'Creating Movie...........'

movies_url = 'https://api.themoviedb.org/3/discover/movie?api_key=37ad0282d6e101d37cc25353577d615f&primary_release_date.gte=2022-09-05'
movies_database_serialized = URI.parse(movies_url).open.read
movies_database = JSON.parse(movies_database_serialized)
pages_number = movies_database["total_pages"]

(1..pages_number).to_a.each do |page_number|
  movies_url = "https://api.themoviedb.org/3/discover/movie?api_key=37ad0282d6e101d37cc25353577d615f&primary_release_date.gte=2022-09-05&page=#{page_number}"
  movies_database_serialized = URI.parse(movies_url).open.read
  movies_database = JSON.parse(movies_database_serialized)
  movies_results = movies_database["results"].count
  (0..(movies_results - 1)).to_a.each do |i|
    movie = movies_database['results'][i]
    movie_id = movie['id']
    cast_movie_url = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?api_key=37ad0282d6e101d37cc25353577d615f"
    cast_movie_serialized = URI.parse(cast_movie_url).open.read
    cast_movie = JSON.parse(cast_movie_serialized)
    director = cast_movie['crew'].find { |hash| hash['job'] == 'Director' }
    director = "unknown" if director.nil?
    genre_ids = movie['genre_ids']
  
    Movie.create(title: movie['title'],
                 director: director['name'],
                 synopsis: movie['overview'],
                 release_date: movie['release_date'].to_date,
                 poster_path: "https://image.tmdb.org/t/p/original/#{movie['poster_path']}")
    puts "Movie created"
  
    genre_ids.each do |id|
      genre = genres.find { |hash| hash['id'] == id }
      puts "genre = #{genre}"
      next unless genre
  
      GenreMovie.create(genre: Genre.find_by_name(genre['name']), movie: Movie.last)
      puts "genre_movie created"
    end
    puts "next"   
  end
  puts "page #{page_number} done !!!!!!!!!!!!"
end

puts 'Success'
