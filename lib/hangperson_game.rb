class HangpersonGame
 
  attr_accessor :word, :guesses, :wrong_guesses,:repeated
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(letter)
    @repeated = false 
    if letter.nil? || !(/^[a-zA-Z]+$/).match(letter) || letter.empty?
      raise ArgumentError
    else 
      letter.split().each do |c|
        if !@word.include? c 
          if !@wrong_guesses.include? c
            @wrong_guesses += c
            return true 
          else 
            
            return false
          end 
          #flash[:message] = "Invalid guess."
        else
          if !@guesses.include? c
            @guesses += c
            return true 
          else 
            @repeated = true 
            #flash[:message] = "You have already used that letter."
            return false 
          end 
        end 
      end 
    end 
  end 

  def word_with_guesses()
    result = ""
    @word.chars do |c|
      if @guesses.include? c
        result = result + c
      else
        result = result + "-"
      end
    end
    return result
  end 

  def check_win_or_lose
    sofar = word_with_guesses()
    if @wrong_guesses.length >= 7
      return :lose
    elsif ! sofar.include? "-"
      return :win
    else
      return :play
    end 
  end 

	# , :guesses,  :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
