# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

class NoMoreRollsException < RuntimeError; end

class DiceSet

  attr_reader :values

  def initialize
    @values = []
  end

  def roll(num)
    @values = []
    num.times { @values << rand(1..6) } if num.is_a? Integer
  end
end

class Player
  attr_reader :total_points, :combinations

  def initialize
    @rolls = 0
    @combinations = []
    @total_points = 0
    @dice_set = DiceSet.new
  end

  def roll
    raise NoMoreRollsException if @rolls >= 5

    @rolls += 1
    @dice_set.roll(5)
    @dice_set.values
  end

  def add_combination(combination)
    @combinations << combination
  end

  def add_points(value)
    @total_points += value
  end

  def count_rolls_left
    5 - @rolls
  end
end

class Game

  def initialize
    @player = Player.new
  end

  def start
    while @player.count_rolls_left.positive?
      combination = @player.roll
      @player.add_combination(combination)

      combination_score = score(combination)
      @player.add_points(combination_score)
    end

    print_end_game_msg
  end

  private

  def print_end_game_msg
    puts 'Combinations: ', @player.combinations.to_s
    puts 'Total points: ', @player.total_points

    if @player.total_points > 3000
      puts 'YAY! You won the game! You are really lucky!'
    else
      puts 'Aww too bad, you lost! Try next time!'
    end
  end

  # noinspection DuplicatedCode
  def score(dice)
    # You need to write this method
    roll_hash = {}

    dice.each do |value|
      roll_hash[value] = 0 if roll_hash[value].nil?

      roll_hash[value] += 1
    end

    calculate_combination_points(roll_hash)
  end

  # noinspection DuplicatedCode
  def calculate_combination_points(hash)
    hash.reduce(0) do |acc, h|

      if h[1] >= 3

        remainder = h[1] - 3

        acc += h[0] == 1 ? 1000 : h[0] * 100

        next(acc) if remainder.zero?
      end

      remainder = h[1] > 3 ? (h[1] - 3) : h[1]

      if h[0] == 1
        acc += remainder * 100
        next(acc)
      end

      if h[0] == 5
        acc += remainder * 50
        next(acc)
      end

      acc
    end
  end
end

game = Game.new
game.start
