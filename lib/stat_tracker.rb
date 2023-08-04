# require './lib/game_parser'
# require './lib/team_result_parser'

class StatTracker

  def initialize(locations)
    @game_parser = GameParser.new
    @result_parser = TeamResultParser.new
    @league_parser = LeagueParser.new
    @game_parser.get_game_info(locations[:games])
    @result_parser.get_game_team_info(locations[:game_teams])
    @league_parser.list_teams(locations[:teams])
  end

  def self.from_csv(locations)
    self.new(locations)
  end

  def winningest_coach(season_id)
    season_hash = @game_parser.get_season_games(season_id)
    season_games = season_hash[true]
    games_played_in_season = @result_parser.get_win_games_from_season(season_games)
  end

  def worst_coach(season_id)
    season_hash = @game_parser.get_season_games(season_id)
    season_games = season_hash[true]
    games_played_in_season = @result_parser.get_lose_games_from_season(season_games)
  end
end