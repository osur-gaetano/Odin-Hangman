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
