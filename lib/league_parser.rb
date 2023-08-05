require "csv"
require_relative "./team"

class LeagueParser
  attr_reader :teams_list

  def initialize
    @teams_list = []
  end
  
  def list_teams(team_path)
    contents = CSV.open team_path, headers: true, header_converters: :symbol
    contents.each do |row|
      team_id = row[:team_id]
      team_name = row[:teamname]
      stadium = row[:stadium]
      new_team = Team.new(team_id, team_name, stadium)
      @teams_list << new_team
    end
    @teams_list
  end

  def count_of_teams
    @teams_list.count
  end

  def get_team_list
    @teams_list
  end

  def get_team_name(id_of_team)
    name = ""
    teams_list.each do |team|
      if team.team_id.to_i == id_of_team
        name = team.team_name
      end
    end
    name
  end
end