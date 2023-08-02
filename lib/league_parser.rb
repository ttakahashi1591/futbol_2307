require "csv"

class LeagueParser
  attr_reader :teams,
              :teams_list

  def initialize(teams)
    @teams = CSV.open "./data/teams.csv", headers: true, header_converters: :symbol
    @teams_list = list_teams
  end

  def list_teams
    @teams.map do |row|
      team_id = row[:team_id]
      team_name = row[:teamname]
      stadium = row[:stadium]

      # Team.new(team_id, team_name, stadium)
    end
  end
end