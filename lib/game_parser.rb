require "csv"
require './lib/game'
class GameParser
  attr_reader :games
  def initialize
    @games = []
  end

  def get_game_info
    contents = CSV.open "./data/game_fixture.csv", headers: true, header_converters: :symbol
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
end