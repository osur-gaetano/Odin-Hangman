# frozen_string_literal: false

# Player class
class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

# HumanPlayer Class
# Inherits from Player class
class HumanPlayer < Player
  attr_accessor :guess, :wins

  def initialize(name)
    super
    @wins = 0
  end

  def make_guess
    puts 'Make a guess, one characer at a time'
    @guess = gets[0]
  end
end

# ComputerPlayer class
# Inherits from the Player class
class ComputerPlayer < Player
  attr_accessor :secret, :word_file

  def initialize(word_file, name = 'Javis')
    super(name)
    @secret = nil
    @word_file = word_file
  end

  def generate_secret_word
    word_list = []
    File.foreach(@word_file) do |line|
      word_list.append(line.downcase.chomp) if line.chomp.length > 5 && line.chomp.length < 13
    end
    @secret = word_list.sample
  end
end

puts "-*-*-*-*-*-*-*-*-*-*- Let's Hang the Man -*-*-*-*-*-*-*-*-*-*-*-*-"

wordlist_file = 'google-10000-english-no-swears.txt'
