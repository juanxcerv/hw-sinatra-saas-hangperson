# Pair Programming: Melvin Hernandez 24813801
class HangpersonGame attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  def check_win_or_lose()
    if @wrong_guesses.length >= 7
      return :lose
    end
    if not @word_with_guesses.include? "-"
      return :win
    end
    return :play
  end

  def initialize_word_with_guesses()
    @word_with_guesses = "-" * @word.length
  end

  def add_to_worth_with_guesses(guessed_letter)
    @word.each_char.each_with_index do |letter, index|
      if letter == guessed_letter
        @word_with_guesses[index] = letter
      end
    end
  end

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    initialize_word_with_guesses()
  end

  def alpha?(l)
    l =~ /[[:alpha:]]/
  end

  def guess(letter)
    if letter.nil? || letter.empty? || (not alpha?(letter))
      raise ArgumentError, 'Argument is not valid'
    end

    letter = letter.downcase
  
    if (@guesses.include? letter) || (@wrong_guesses.include? letter)
      return false
    end

    if @word.include? letter
      @guesses += letter
      add_to_worth_with_guesses(letter)
    else
      @wrong_guesses += letter
    end
    return check_win_or_lose()
  end
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
