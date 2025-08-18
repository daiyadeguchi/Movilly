namespace :call_movie do
  desc "testing rake"
  task call: :environment do
    movie = Movie.new
    movies = movie.create_movies
    puts movies
  end
end
