# This class is pulling data from games.csv (or its fixture for testing purposes)
# We will use game_id, season, away_team_id, home_team_id, away_goals, home_goals

require "csv"
require_relative './game'
class GameParser
  attr_reader :games
  def initialize
    @games = []
  end

  def get_game_info(games_path)
    contents = CSV.open games_path, headers: true, header_converters: :symbol
    contents.each do |row|
      game_id = row[:game_id]
      season = row[:season]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id]
      away_goals = row[:away_goals]
      home_goals = row[:home_goals]
      game = Game.new(game_id, season, away_team_id, home_team_id, away_goals, home_goals)
      @games << game
    end
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
      game.away_goals.to_i + game.home_goals.to_i
    end
    result.away_goals.to_i + result.home_goals.to_i
  end

  def count_of_games_by_season
    groups = @games.group_by do |game|
      game.season
    end
    group_hash = {}
   
    groups.each do |key, value|
      group_hash[key] = value.count
    end
    group_hash
  end

  def average_goals_per_game
    total_goals = @games.sum do |game|
      game.away_goals.to_f + game.home_goals.to_f
    end
    (total_goals/@games.count).round(2)
  end

  def average_goals_by_season
    groups = @games.group_by do |game|
      game.season
    end
    group_hash = {}
   
    groups.each do |key, value|
      goal_sum = value.sum do |group_game|
        (group_game.away_goals.to_f + group_game.home_goals.to_f)
      end
      group_hash[key] = (goal_sum/value.count).round(2)
    end
    group_hash
  end

  def get_season_games(season_id)
    season_games = @games.group_by do |game|
      game.season == season_id
    end
  end
end