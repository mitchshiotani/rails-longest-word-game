require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def score
    @word = (params[:word] || '').upcase
    @letters = params[:letters].split
    if grid_valid?(@word, @letters) == false
      @message = "Sorry but #{@word} can't be built out of ."
    elsif eng_valid?(@word) == false
      @message = "Sorry but #{@word} does not seem to be a valid English word."
    else
      @message = "Congratulations! #{@word} is a valid English word."
    end
  end

  def grid_valid?(word, letters)
    # make hashes with key as letter and value as count, for word and grid
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def eng_valid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result = JSON.parse(open(url).read)
    result['found']
  end
end





