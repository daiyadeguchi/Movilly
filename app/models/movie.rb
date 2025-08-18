class Movie < ApplicationRecord
  validates :hashed_id, :title, presence: true

  def create_movies
    ChatbotService.new.call
  end
end
