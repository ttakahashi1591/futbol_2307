# This class will pull from game_teams.csv.
# We need game_id, team_id, HoA, result, head_coach, goals, shots, tackles

require "csv"
require_relative './team_result'
require_relative './league_parser'

class TeamResultParser

  attr_reader :game_data_by_team

  def initialize
    @game_data_by_team = []
    @league_parser = LeagueParser.new
    @team_path = './data/teams.csv'
  end

  def get_game_team_info(game_teams_path)
    contents = CSV.open game_teams_path, headers: true, header_converters: :symbol
    contents.each do |row|
      game_id = row[:game_id]
      team_id = row[:team_id]
      hoa = row[:hoa]
      result = row[:result]
      head_coach = row[:head_coach]
      goals = row[:goals]
      shots = row[:shots]
      tackles = row[:tackles]
      game = TeamResult.new(game_id,team_id,hoa,result,
      head_coach,goals,shots,tackles)
      @game_data_by_team << game
    end
  end

  def percentage_home_wins
    home_wins = @game_data_by_team.count do |team|
      team.hoa == "home" && team.result == "WIN"
    end
    home_games = @game_data_by_team.count do |team2|
      team2.hoa == "home"
    end
    (home_wins.to_f / home_games.to_f).round(2)
  end

  def percentage_visitor_wins
    away_wins = @game_data_by_team.count do |team|
      team.hoa == "away" && team.result == "WIN"
    end
    away_games = @game_data_by_team.count do |team2|
      team2.hoa == "away"
    end
    (away_wins.to_f / away_games.to_f).round(2)
  end

  def percentage_ties
    tied_games = @game_data_by_team.count do |team|
      team.result == "TIE"
    end
    (tied_games.to_f / @game_data_by_team.count.to_f).round(2)
  end

  def get_tackles_in_season(season_games)
    tackles_by_team = Hash.new(0)
    @game_data_by_team.each do |game|
      season_games.each do |season_game|
        if game.game_id == season_game.game_id
          tackles_by_team[game.team_id.to_i] += game.tackles.to_i
        end
      end
    end
    tackles_by_team
  end

  def most_tackles_in_season_team_id(season_games)
    most_tackles_team_id = get_tackles_in_season(season_games).max_by do |team_id, tackles|
      tackles
    end
    most_tackles_team_id.first
  end

  def least_tackles_in_season_team_id(season_games)
    least_tackles_team_id = get_tackles_in_season(season_games).min_by do |team_id, tackles|
      tackles
    end
    least_tackles_team_id.first
  end

  def get_win_percentage(season_games)
    games_played = []
    @game_data_by_team.each do |game|
      season_games.each do |season_game|
        if game.game_id == season_game.game_id
          games_played << game
        end
      end
    end
    coach_played = Hash.new(0)
    games_played.each do |play|
      coach_played[play.head_coach] += 1
    end
    win_games = games_played.find_all do |w_game|
      w_game.result == "WIN"
    end
    coach_win = Hash.new(0)
    win_games.each do |win|
      coach_win[win.head_coach] += 1
    end
    win_percent = Hash.new(0)
    coach_played.each do |play_k, play_v|
      coach_win.each do |win_k, win_v|
        if play_k == win_k
          win_percent[play_k] = (win_v.to_f / play_v.to_f)
        elsif !coach_win.keys.include?(play_k)
          win_percent[play_k] = 0
        end
      end
    end
    win_percent
  end

  def get_win_games_from_season(season_games)
    win_percent = get_win_percentage(season_games)
    most_pop_coach = win_percent.max_by do |k,v|
      v
    end
    most_pop_coach.first
  end

  def get_lose_games_from_season(season_games)
    win_percent = get_win_percentage(season_games)
    most_pop_coach = win_percent.min_by do |k,v|
      v
    end
    most_pop_coach.first
  end
  
  def best_offense
    best_offense = nil
    @league_parser.list_teams(@team_path)
    teams = @league_parser.get_team_list
    teams.each do |team|
      if team.team_id.to_i == find_best_worst_offense_team_id_by_location("both", "best")
        best_offense = team.team_name
      end
    end
    best_offense
  end

  def worst_offense
    worst_offense = nil
    @league_parser.list_teams(@team_path)
    teams = @league_parser.get_team_list
    teams.each do |team|
      if team.team_id.to_i == find_best_worst_offense_team_id_by_location("both", "worst")
        worst_offense = team.team_name
      end
    end
    worst_offense
  end

  def find_best_worst_offense_team_id_by_location(location, goodness)
    a = alltime_goals_per_team_by_location(location)
    b = games_played_per_team_by_location(location)
    
    c = a.merge(b) { |team_id, goals, games| goals.to_f / games.to_f }
    
    if goodness == "best"
      min_or_max = c.key(c.values.max)
    elsif goodness == "worst"
      min_or_max = c.key(c.values.min)
    end
    min_or_max
  end

  def alltime_goals_per_team_by_location(location)
    goals_hash = Hash.new(0)
    counter = 1
    
    54.times do
      @game_data_by_team.each do |game|
        if location == "both" &&
        game.team_id.to_i == counter
          goals_hash[game.team_id.to_i] += game.goals.to_i
        elsif location == "home" &&
        game.hoa == location &&
        game.team_id.to_i == counter
          goals_hash[game.team_id.to_i] += game.goals.to_i
        elsif location == "away" &&
        game.hoa == location &&
        game.team_id.to_i == counter
          goals_hash[game.team_id.to_i] += game.goals.to_i
        end
      end
      counter += 1
    end
    goals_hash
  end

  def games_played_per_team_by_location(location)
    games_played = Hash.new(0)
    counter = 1

    54.times do
      @game_data_by_team.each do |game|
        if location == "both" &&
        game.team_id.to_i == counter
          games_played[game.team_id.to_i] += 1
        elsif location == "home" &&
        game.hoa == location &&
        game.team_id.to_i == counter
          games_played[game.team_id.to_i] += 1
        elsif location == "away" &&
        game.hoa == location &&
        game.team_id.to_i == counter
          games_played[game.team_id.to_i] += 1
        end
      end
      counter += 1
    end
    games_played
  end

  def highest_scoring_home_team
    best_home_team = nil
    @league_parser.list_teams(@team_path)
    teams = @league_parser.get_team_list
    teams.each do |team|
      if team.team_id.to_i == find_best_worst_offense_team_id_by_location("home", "best")
        best_home_team = team.team_name
      end
    end
    best_home_team
  end

  def lowest_scoring_home_team
    worst_home_team = nil
    @league_parser.list_teams(@team_path)
    teams = @league_parser.get_team_list
    teams.each do |team|
      if team.team_id.to_i == find_best_worst_offense_team_id_by_location("home", "worst")
        worst_home_team = team.team_name
      end
    end
    worst_home_team
  end

  def highest_scoring_visitor
    best_visiting_team = nil
    @league_parser.list_teams(@team_path)
    teams = @league_parser.get_team_list
    teams.each do |team|
      if team.team_id.to_i == find_best_worst_offense_team_id_by_location("away", "best")
        best_visiting_team = team.team_name
      end
    end
    best_visiting_team
  end

  def lowest_scoring_visitor
    worst_visiting_team = nil
    @league_parser.list_teams(@team_path)
    teams = @league_parser.get_team_list
    teams.each do |team|
      if team.team_id.to_i == find_best_worst_offense_team_id_by_location("away", "worst")
        worst_visiting_team = team.team_name
      end
    end
    worst_visiting_team
  end

  def get_season_goals(season_games)
    goals_by_team = Hash.new(0)
    @game_data_by_team.each do |game|
      season_games.each do |season_game|
        if game.game_id == season_game.game_id
          goals_by_team[game.team_id.to_i] += game.goals.to_i
        end
      end
    end
    goals_by_team
  end

  def get_season_shots(season_games)
    shots_by_team = Hash.new(0)
    @game_data_by_team.each do |game|
      season_games.each do |season_game|
        if game.game_id == season_game.game_id
          shots_by_team[game.team_id.to_i] += game.shots.to_i
        end
      end
    end
    shots_by_team
  end

  def goal_to_shot_ratio_team_id_max(season_games)
    a = get_season_goals(season_games)
    b = get_season_shots(season_games)

    c = a.merge(b) { |team_ids, goals, shots| goals.to_f / shots.to_f }

    c.key(c.values.max)
  end

  def goal_to_shot_ratio_team_id_min(season_games)
    a = get_season_goals(season_games)
    b = get_season_shots(season_games)

    c = a.merge(b) { |team_ids, goals, shots| goals.to_f / shots.to_f }

    c.key(c.values.min)
  end
end