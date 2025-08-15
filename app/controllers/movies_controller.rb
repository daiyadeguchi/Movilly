require "net/http"

class MoviesController < ApplicationController
  def index
    chatbot = ChatbotService.new(params[:category])
    res_body = chatbot.call
    @res = JSON.parse(res_body["choices"][0]["message"]["content"].split("</think>")[1])
  end
end
