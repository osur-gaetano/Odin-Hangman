# frozen_string_literal: false

require 'json'

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

  def initialize(word_file = nil, name = 'Javis')
    super(name)
    @word_file = word_file
  end

  def generate_secret_word
    word_list = []
    File.foreach(@word_file) do |line|
      word_list.append(line.downcase.chomp) if line.chomp.length > 5 && line.chomp.length < 13
    end
    @secret = word_list.sample
  end

  def save_secret_word(saved_secret)
    @secret = saved_secret
  end
end

# HangMan game class
class HangManGame
  attr_accessor :game_secret, :human_player, :current_iteration
  attr_reader :computer_player

  def initialize(computer_player, human_player, current_iteration = 0)
    @computer_player = computer_player
    @human_player = human_player
    @current_iteration = current_iteration
  end

  def current_game_secret
    @game_secret = @computer_player.secret
  end

  def make_a_guess
    puts "#{@human_player.name} Now is the time to liberate the man or send him to the gullows !!!! "
    puts
    current_guess = human_player.make_guess
    if @game_secret_array.include? current_guess
      @game_secret_array.each_index.select do |index|
        @guess_attempt[index] = current_guess if @game_secret_array[index] == current_guess
      end
    end
    puts
    puts "The current game_secret is : #{@game_secret_array.join(' ')} \n"
    puts "The current guess state is : #{@guess_attempt.join(' ')} \n"
  end

  def start_menu
    start_menu_options = [
      ' 1: Continue with saved Hangman Game ?',
      ' 2: Start a New Hangman Game '
    ]
    start_menu_options.each do |option|
      puts option
    end
    puts 'Choese one of the two options [ 1 or 2 ]'
    choice = gets.chomp.to_i
    if choice.eql? 1
      HangManGame.load_saved_game
      puts
      puts "the game has changed, the player is #{@human_player.name} and we are in iteration #{@current_iteration}"
      puts
    end
  end

  def game_play_menu
    game_play_menu_options = [
      ' 1.  Save current game',
      ' 2.  Continue Making guess',
      ' 3.  Exit game'
    ]
    game_play_menu_options.each do |option|
      puts option
    end
    puts 'Choose one of the three options [ 1 or 2 or 3 ]'
    choice = gets.chomp.to_i
    if choice.eql? 1
      save_game_progress
    end
  end

  def game_play(saved_data = nil)
    if !saved_data.nil?
      secret_saved = saved_data[0][0]
      @computer_player.save_secret_word(secret_saved)
      @guess_attempt = saved_data[0][3]
      current_game_secret
    elsif saved_data == nil
      start_menu
      @computer_player.generate_secret_word
      current_game_secret
      @guess_attempt = Array.new(current_game_secret.length, '_')
    end
    @guess_attempt_allowed = (@game_secret.length * 1.5 + 1)
    @game_secret_array = @game_secret.split('')
    loop do
      if @current_iteration < @guess_attempt_allowed
        game_play_menu
        p "This is iteration #{@current_iteration}"
        make_a_guess
        break if @guess_attempt.join('').eql? @game_secret
      else
        puts "You've had your chances and its time to 'Hang THE Man'!!! \n"
        break
      end
      @current_iteration += 1
    end
  end
end

puts "-*-*-*-*-*-*-*-*-*-*- Let's Hang the Man -*-*-*-*-*-*-*-*-*-*-*-*-"

wordlist_file = 'google-10000-english-no-swears.txt'

human_player = HumanPlayer.new('Gaetano56')
computer_player = ComputerPlayer.new(wordlist_file)
game = HangManGame.new(computer_player, human_player)
# game.game_play
game.game_play2(nil)
