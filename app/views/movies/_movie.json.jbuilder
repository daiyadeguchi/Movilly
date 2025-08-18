json.extract! movie, :id, :hashed_id, :title, :category, :created_at, :updated_at
json.url movie_url(movie, format: :json)
