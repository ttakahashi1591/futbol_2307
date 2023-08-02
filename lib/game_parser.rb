require "csv"
require './lib/game'
class GameParser
  attr_reader :games
  def initialize
    @games = []
  end

  def get_game_info
    contents = CSV.open "./data/games.csv", headers: true, header_converters: :symbol
    contents.each do |row|
      game_id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      venue = row[:venue]
      game = Game.new(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue)
      @games << game
    end
    p @games.first
  end

  def highest_total_score
    score = 0
    @games.each do |game|
      sum = game.away_goals.to_i + game.home_goals.to_i
      if sum > score
        score = sum
      end
    end
    score
  end

  def lowest_total_score
    result = @games.min_by do |game|
      require 'pry';binding.pry
      game.away_goals.to_i + game.home_goals.to_i
    end
    result.away_goals.to_i + result.home_goals.to_i
  end
end