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
end