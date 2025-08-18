require "net/http"
require "json"

class ChatbotService
  def call
    uri = URI.parse("http://127.0.0.1:1337/v1/chat/completions")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req["Authorization"] = "Bearer justatest"

    movies = get_movies(http, req, "cry")
    movies.concat(get_movies(http, req, "laugh"))
  end

  private

  def get_movies(http, req, category_verb)
    req.body = construct_body(category_verb)
    res = http.request(req)
    if res.is_a?(Net::HTTPSuccess)
      res_body = JSON.parse(res.body)
      res_body["choices"][0]["message"]["content"].split("</think>")[1]
    else
      puts "Error getting movies from jan: #{res.code}"
    end
  end

  def construct_body(category)
    content = "Give me a json formatted list of five movies that makes me #{category}. for example { 'title': 'ショーシャンクの空に' }. Please make it very random as well."
    data = {
      "model": "Jan-v1-4B-Q4_K_M",
      "messages": [ { "role": "user", "content": content } ]
    }
    data.to_json
  end
end
