require "csv"

class LeagueParser
  attr_reader :teams_list

  def initialize
    @teams_list = []
  end
  
  def list_teams
    contents = CSV.open "./data/teams.csv", headers: true, header_converters: :symbol
    contents.each do |row|
      team_id = row[:team_id]
      team_name = row[:teamname]
      stadium = row[:stadium]
      new_team = Team.new(team_id, team_name, stadium)
      @teams_list << new_team
    end
    @teams_list
  end
end