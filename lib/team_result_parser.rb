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

  def highest_scoring_home_team(teams)
    best_home_team = nil
    teams.each do |team|
      if team.team_id.to_i == highest_scoring_home_team_id
        best_home_team = team.team_name
      end
    end
    best_home_team
  end

  def lowest_scoring_home_team(teams)
    worst_home_team = nil
    teams.each do |team|
      if team.team_id.to_i == lowest_scoring_home_team_id
        worst_home_team = team.team_name
      end
    end
    worst_home_team
  end

  def highest_scoring_visitor(teams)
    best_visiting_team = nil
    teams.each do |team|
      if team.team_id.to_i == highest_scoring_visiting_team_id
        best_visiting_team = team.team_name
      end
    end
    best_visiting_team
  end

  def lowest_scoring_visitor(teams)
    worst_visiting_team = nil
    teams.each do |team|
      if team.team_id.to_i == lowest_scoring_visiting_team_id
        worst_visiting_team = team.team_name
      end
    end
    worst_visiting_team
  end

  def alltime_goals_per_home_team #helper method
    home_goals_hash = Hash.new(0)
    counter = 1
    
    54.times do
      @game_data_by_team.each do |game|
        if game.hoa == "home"
          if game.team_id.to_i == counter
            home_goals_hash[game.team_id.to_i] += game.goals.to_i
          end
        end
      end
      counter += 1
    end
    home_goals_hash
  end

  def alltime_goals_per_visiting_team #helper method
    visitor_goals_hash = Hash.new(0)
    counter = 1
    
    54.times do
      @game_data_by_team.each do |game|
        if game.hoa == "away"
          if game.team_id.to_i == counter
            visitor_goals_hash[game.team_id.to_i] += game.goals.to_i
          end
        end
      end
      counter += 1
    end
    visitor_goals_hash
  end

  def home_games_played_per_team #helper method
    home_games_played = Hash.new(0)
    counter = 1

    54.times do
      @game_data_by_team.each do |game|
        if game.team_id.to_i == counter
          home_games_played[game.team_id.to_i] += 1
        end
      end
      counter += 1
    end
    home_games_played
  end

  def visiting_games_played_per_team #helper method
    visitor_games_played = Hash.new(0)
    counter = 1

    54.times do
      @game_data_by_team.each do |game|
        if game.team_id.to_i == counter
          visitor_games_played[game.team_id.to_i] += 1
        end
      end
      counter += 1
    end
    visitor_games_played
  end

  def highest_scoring_home_team_id
    a = alltime_goals_per_home_team
    b = home_games_played_per_team
    c = a.merge(b) { |team_id, goals, games| goals.to_f / games.to_f }
    c.key(c.values.max)
  end

  def lowest_scoring_home_team_id
    a = alltime_goals_per_home_team
    b = home_games_played_per_team
    c = a.merge(b) { |team_id, goals, games| goals.to_f / games.to_f }
    c.key(c.values.min)
  end

  def highest_scoring_visiting_team_id
    a = alltime_goals_per_visiting_team
    b = visiting_games_played_per_team
    c = a.merge(b) { |team_id, goals, games| goals.to_f / games.to_f }
    c.key(c.values.max)
  end

  def lowest_scoring_visiting_team_id
    a = alltime_goals_per_visiting_team
    b = visiting_games_played_per_team
    c = a.merge(b) { |team_id, goals, games| goals.to_f / games.to_f }
    c.key(c.values.min)
  end
end