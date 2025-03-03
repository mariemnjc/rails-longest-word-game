require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:tags_list].upcase
    @letters = params[:letters]
    @valid_letters = @word.chars.all? do |letter|
                  @word.count(letter) <= @letters.count(letter)
                end

    if @valid_letters
      url = "https://dictionary.lewagon.com/#{@word}"
      app_url = URI.open(url).read
      user = JSON.parse(app_url)
      @valid_word = user["found"]
    end

    if @valid_word
      @message = "Congratulations"
    elsif @valid_letters
      @message = "Sorry but #{@word} can't be build out of #{@letters}"
    else
      @message = 'Sorry try again'
    end
  end
end
