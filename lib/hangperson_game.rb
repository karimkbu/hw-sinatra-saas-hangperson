class HangpersonGame
attr_accessor :word
attr_accessor :guesses
attr_accessor :wrong_guesses


  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
   def guess(letter)
    raise ArgumentError if letter.nil?
    letter.downcase!
    not_guessed = !(@guesses.include?(letter)) && !(@wrong_guesses.include?(letter))
    alphabet = !!(letter =~ /[a-z]/)
    raise ArgumentError if !alphabet || letter.empty?
    valid = false
    
    if (not_guessed == true)
        valid = true
    else
        return false
    end

    
    
    if @word.include?(letter)
        @guesses += letter
    else
        @wrong_guesses += letter
    end
    return valid
  end

  def word_with_guesses
    temp = '-' * @word.length 
    @word.each_char.with_index do |letter,ind|
        if @guesses.include?(letter)
            temp[ind] = letter
        end
    end
    return temp
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
