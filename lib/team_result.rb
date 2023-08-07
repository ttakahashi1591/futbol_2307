# This class will pull from game_teams.csv.
# We need game_id, team_id, HoA, result, head_coach, goals, shots, tackles

class TeamResult
  attr_reader :game_id,
              :team_id,
              :hoa,
              :result,
              :head_coach,
              :goals,
              :shots,
              :tackles
              
  def initialize(game_id,
                  team_id,
                  hoa,
                  result,
                  head_coach,
                  goals,
                  shots,
                  tackles)
                  
    @game_id = game_id
    @team_id = team_id
    @hoa = hoa
    @result = result
    @head_coach = head_coach
    @goals = goals
    @shots = shots
    @tackles = tackles
  end
end