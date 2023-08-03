# This class is pulling data from games.csv (or its fixture for testing purposes)
# We will use game_id, season, away_team_id, hone_team_id, away_goals, home_goals

class Game 
  attr_reader :game_id, 
              :season, 
              :type, 
              :date_time, 
              :away_team_id, 
              :home_team_id, 
              :away_goals, 
              :home_goals, 
              :venue
  
  def initialize(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue)
    @game_id = game_id
    @season = season
    @type = type
    @date_time = date_time
    @away_team_id = away_team_id
    @home_team_id = home_team_id
    @away_goals = away_goals
    @home_goals = home_goals
    @venue = venue
  end
end
