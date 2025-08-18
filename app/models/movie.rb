class Movie < ApplicationRecord
  def create_movies
    movies = ChatbotService.new.call
    puts movies
  end
end
