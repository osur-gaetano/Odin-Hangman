# frozen_string_literal:false

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class ComputerPlayer < Player
  attr_accessor :secret

  def initialize(name = 'Javis')
    super(name)
  end

  def secret_word(secret)
    @secret = secret
  end
end

class HumanPlayer < Player
  attr_accessor :guess, :wins

  def initialize(name)
    super(name)
    @wins = 0
  end

  def make_guess
    puts 'Make a guess, one characer at a time'
    @guess = gets[0]
  end
end

class HangManGame
  attr_accessor :secret_word, :player_one, :computer_player, :word_file

  def initialize(computer_player, human_player, file)
    @computer_player = computer_player
    @player_one = human_player
    @word_file = file
  end

  def generate_secret_word
    word_list = []
    File.foreach(@word_file) do |line|
      word_list.append(line.downcase.chomp) if line.chomp.length > 5 && line.chomp.length < 13
    end
    @secret_word = word_list.sample
  end

  def play
    @computer_player.secret_word(@secret_word)
    guess_numbers_aloowed = (@secret_word.length * 1.5 + 1)
    current_game_secret = @computer_player.secret.split('')
    current_geme_guess = Array.new(current_game_secret.length, '_')

    iteration = 0
    loop do
      if iteration < guess_numbers_aloowed
        p "This is iteration #{iteration} \n"
        puts "#{player_one.name} make your guess\n"
        current_player_one_guess = player_one.make_guess
        if current_game_secret.include? current_player_one_guess
          current_game_secret.each_index.select do |index|
            current_geme_guess[index] = current_player_one_guess if current_game_secret[index] == current_player_one_guess
          end
        end
        puts "The current game_secret is : #{current_game_secret.join(' ')} \n"
        puts "The current guess state is : #{current_geme_guess.join(' ')} \n"
        break if current_geme_guess.eql? current_game_secret
      else
        puts "You've had your chances and its time to 'Hang THE Man'!!! \n"
        break
      end
      iteration += 1
    end
  end
end

puts "-*-*-*-*-*-*-*-*-*-*- Let's Hang the Man -*-*-*-*-*-*-*-*-*-*-*-*-"

word_file = 'google-10000-english-no-swears.txt'

puts 'What is your name, human player? '
human_name = gets.downcase.chomp
human_player = HumanPlayer.new(human_name)
computer_player = ComputerPlayer.new

game = HangManGame.new(computer_player, human_player, word_file)
game.generate_secret_word
game.play
