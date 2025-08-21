require "net/http"
require "json"

class ChatbotService
  def call
    uri = URI.parse("http://127.0.0.1:1337/v1/chat/completions")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req["Authorization"] = "Bearer justatest"

    hash = movie_to_hasharray(get_movies(http, req, "cry"), :sad)
    hash.push(movie_to_hasharray(get_movies(http, req, "laugh"), :laugh))
  end

  private

  @@models = { jan_v1: "Jan-v1-4B-Q4_K_M", jan_nano: "jan-nano-128k-Q4_K_M" }

  def get_movies(http, req, category_verb)
    req.body = construct_body(category_verb)
    res = http.request(req)
    if res.is_a?(Net::HTTPSuccess)
      res_body = JSON.parse(res.body)
      lines = res_body["choices"][0]["message"]["content"].split("\n")
      lines.inspect # inspect to make array to string for future JSON.parse
    else
      puts "Error getting movies from jan: #{res.code}"
    end
  end

  def construct_body(category)
    content = "Give me a json formatted list of 15 movies that makes me #{category}. for example { 'title': 'ショーシャンクの空に' }. You don't need to add markdown such as ```json. Please make it very random as well."
    data = {
      "model": @@models[:jan_nano],
      "messages": [ { "role": "user", "content": content } ]
    }
    data.to_json
  end

  def movie_to_hasharray(movies, category)
    movies = JSON.parse(movies)
    movies_hasharray = []
    movies.each do |movie|
      movie = JSON.parse(movie)
      movie_hash = { hashed_id: movie["title"].hash, title: movie["title"], category: category }
      movies_hasharray.push(movie_hash)
    end
    movies_hasharray
  end
end
