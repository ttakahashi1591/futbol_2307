require_relative './game_parser'
require_relative './team_result_parser'
require_relative './league_parser'

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

  def highest_total_score
    @game_parser.highest_total_score
  end

  def lowest_total_score
    @game_parser.lowest_total_score
  end

  def percentage_home_wins
    @result_parser.percentage_home_wins
  end

  def percentage_visitor_wins
    @result_parser.percentage_visitor_wins
  end

  def percentage_ties
    @result_parser.percentage_ties
  end

  def count_of_games_by_season
    @game_parser.count_of_games_by_season
  end

  def average_goals_per_game
    @game_parser.average_goals_per_game
  end

  def average_goals_by_season
    @game_parser.average_goals_by_season
  end

  def count_of_teams
    @league_parser.count_of_teams
  end

  def best_offense
    @result_parser.best_offense
  end

  def worst_offense
    @result_parser.worst_offense
  end

  def highest_scoring_visitor
    @result_parser.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @result_parser.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @result_parser.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @result_parser.lowest_scoring_home_team
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

  def most_tackles(season_id)
    season_hash = @game_parser.get_season_games(season_id)
    season_games = season_hash[true]
    team_id = @result_parser.most_tackles_in_season_team_id(season_games)
    @league_parser.get_team_name(team_id)
  end

  def fewest_tackles(season_id)
    season_hash = @game_parser.get_season_games(season_id)
    season_games = season_hash[true]
    team_id = @result_parser.least_tackles_in_season_team_id(season_games)
    @league_parser.get_team_name(team_id)
  end

  def most_accurate_team(season_id)
    season_hash = @game_parser.get_season_games(season_id)
    season_games = season_hash[true]
    team_id = @result_parser.goal_to_shot_ratio_team_id_max(season_games)
    @league_parser.get_team_name(team_id)
  end

  def least_accurate_team(season_id)
    season_hash = @game_parser.get_season_games(season_id)
    season_games = season_hash[true]
    team_id = @result_parser.goal_to_shot_ratio_team_id_min(season_games)
    @league_parser.get_team_name(team_id)
  end
end