require "net/http"
require "json"

class ChatbotService
  def initialize(category = "sad")
    @category = category
  end

  def call
    call_jan
  end

  private

  def call_jan
    uri = URI.parse("http://127.0.0.1:1337/v1/chat/completions")
    http = Net::HTTP.new(uri.host, uri.port)

    movie_category = "cry"
    case @category
    when "sad"
      movie_category = "cry"
    when "laugh"
      movie_category = "laugh"
    else
      movie_category = "cry"
    end

    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req["Authorization"] = "Bearer justatest"
    content = "Give me a json formatted list of five movies that makes me #{movie_category}. for example { 'title': 'ショーシャンクの空に' }. Please make it very random as well."
    puts content
    data = {
      "model": "Jan-v1-4B-Q4_K_M",
      "messages": [ { "role": "user", "content": content } ]
    }
    req.body = data.to_json
    res = http.request(req)
    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)
    else
      puts "Error: #{res.code}"
    end
  end
end
