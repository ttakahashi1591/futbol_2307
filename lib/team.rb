class Team
  attr_reader :team_id,
              :team_name,
              :stadium
              
  def initialize(team_id, team_name, stadium)
    @team_id = team_id
    @team_name = team_name
    @stadium = stadium
  end
end