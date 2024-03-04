require 'open-uri'
require 'json'

class GamesController < ApplicationController

def new
    @letters = []
    10.times do
      @letters << ("a".."z").to_a.sample
    end
    @letters.join
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split
    if english_word? (@word)
      @result = "Congratualtions! #{@word} is a valid English work!"
      unless @word.chars.all? { |letter| @letters.include? letter }
        @result = "Sorry but #{@word} can't be built out of #{@letters.join}"
      end
    else
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end

  def english_word?(word)
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

end
