namespace :call_movie do
  desc "testing rake"
  task call: :environment do
    movie = Movie.new
    movies = movie.create_movies
    movies.each do |movie|
      Movie.create(hashed_id: movie[:hashed_id], title: movie[:title], category: movie[:category])
    end
  end
end
