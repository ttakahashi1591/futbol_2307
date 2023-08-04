require "csv"
require './lib/team_result'
class TeamResultParser
  attr_reader :game_data_by_team
  def initialize
    @game_data_by_team = []
  end

  def get_game_info
    contents = CSV.open "./data/game_teams.csv", headers: true, header_converters: :symbol
    contents.each do |row|
      game_id = row[:game_id]
      team_id = row[:team_id]
      hoa = row[:hoa]
      result = row[:result]
      settled_in = row[:settled_in]
      head_coach = row[:head_coach]
      goals = row[:goals]
      shots = row[:shots]
      tackles = row[:tackles]
      pim = row[:pim]
      powerPlayOpportunities = row[:powerPlayOpportunities]
      powerPlayGoals = row[:powerPlayGoals]
      faceOffWinPercentage = row[:faceOffWinPercentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]
      game = TeamResult.new(game_id,team_id,hoa,result,settled_in,
      head_coach,goals,shots,tackles,pim,powerPlayOpportunities,
      powerPlayGoals,faceOffWinPercentage,giveaways,takeaways)
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


  def get_win_percentage(season_games)
    games_played = []
    @game_data_by_team.each do |game|
      season_games.each do |season_game|
        if game.game_id == season_game.game_id
          games_played << game
        end
      end
    end
    coach_played = {}
    games_played.each do |play|
      if coach_played[play.head_coach] == nil
        coach_played[play.head_coach] = 1
      else
        coach_played[play.head_coach] += 1
      end
    end
    win_games = games_played.find_all do |w_game|
      w_game.result == "WIN"
    end
    coach_win = {}
    win_games.each do |win|
      if coach_win[win.head_coach] == nil
        coach_win[win.head_coach] = 1
      else
        coach_win[win.head_coach] += 1
      end
    end
    win_percent = {}
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

  def alltime_goals_per_team #helper method
    goals_hash = Hash.new(0)
    counter = 1
    
    54.times do
      @game_data_by_team.each do |game|
        if game.team_id.to_i == counter
          goals_hash[game.team_id.to_i] += game.goals.to_i
        end
      end
      counter += 1
    end
    goals_hash
  end
  
  def best_offense(teams)
    best_offense = nil
    teams.each do |team|
      if team.team_id.to_i == find_best_offense_team_id
        best_offense = team.team_name
      end
    end
    # require 'pry'; binding.pry
    best_offense
  end

  def worst_offense(teams)
    worst_offense = nil
    teams.each do |team|
      if team.team_id.to_i == find_worst_offense_team_id
        worst_offense = team.team_name
      end
    end
    # require 'pry'; binding.pry
    worst_offense
  end

  def games_played_per_team #helper method
    games_played = Hash.new(0)
    counter = 1

    54.times do
      @game_data_by_team.each do |game|
        if game.team_id.to_i == counter
          games_played[game.team_id.to_i] += 1
        end
      end
      counter += 1
    end
    games_played
  end

  def find_best_offense_team_id #helper method
    a = alltime_goals_per_team
    b = games_played_per_team

    c = a.merge(b) { |team_id, goals, games| goals.to_f / games.to_f }
  # require 'pry'; binding.pry
    c.key(c.values.max)
  end

  def find_worst_offense_team_id #helper method
    a = alltime_goals_per_team
    b = games_played_per_team

    c = a.merge(b) { |team_id, goals, games| goals.to_f / games.to_f }
  # require 'pry'; binding.pry
    c.key(c.values.min)
  end
end