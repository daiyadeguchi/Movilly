require "net/http"
require "json"

class ChatbotService
  def initialize
  end

  def call
    uri = URI.parse("http://127.0.0.1:1337/v1/chat/completions")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req["Authorization"] = "Bearer justatest"

    get_sad_movies(http, req)
    # get_funny_movies(http, req)
  end

  private

  def get_sad_movies(http, req)
    content = "Give me a json formatted list of five movies that makes me cry. for example { 'title': 'ショーシャンクの空に' }. Please make it very random as well."
    data = {
      "model": "Jan-v1-4B-Q4_K_M",
      "messages": [ { "role": "user", "content": content } ]
    }
    req.body = data.to_json
    res = http.request(req)
    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    else
      puts "Error getting sad movies: #{res.code}"
    end
  end

  def get_funny_movies(http, req)
    content = "Give me a json formatted list of five movies that makes me funny. for example { 'title': 'ショーシャンクの空に' }. Please make it very random as well."
    data = {
      "model": "Jan-v1-4B-Q4_K_M",
      "messages": [ { "role": "user", "content": content } ]
    }
    req.body = data.to_json
    res = http.request(req)
    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    else
      puts "Error getting funny movies: #{res.code}"
    end
  end
end
