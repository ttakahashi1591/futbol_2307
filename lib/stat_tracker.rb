require './lib/game_parser'
require './lib/team_result_parser'
class StatTracker

  def initialize

  end

  def self.from_csv(locations)
    self.new
  end

  def winningest_coach(season_id)
    #temp method call, remove later
    game_parser = GameParser.new
    game_parser.get_game_info
    result_parser = TeamResultParser.new
    result_parser.get_game_info
    season_hash = game_parser.get_season_games(season_id)
    season_games = season_hash[true]
    games_played_in_season = result_parser.get_win_games_from_season(season_games)
    # require 'pry';binding.pry
  end

  def worst_coach(season_id)
    #temp method call, remove later
    game_parser = GameParser.new
    game_parser.get_game_info
    result_parser = TeamResultParser.new
    result_parser.get_game_info
    season_hash = game_parser.get_season_games(season_id)
    season_games = season_hash[true]
    games_played_in_season = result_parser.get_lose_games_from_season(season_games)
    # require 'pry';binding.pry
  end
end