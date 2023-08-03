require "./lib/league_parser"
require "./lib/team"

RSpec.describe Team do
  describe "initialize" do
    it "#exists" do
      team = Team.new(3, "Houston Dynamo", "BBVA Stadium")
    
      expect(team).to be_a(Team)
    end
  
    it "has readable attributes" do
      team = Team.new(3, "Houston Dynamo", "BBVA Stadium")

      expect(team.team_id).to be(3)
      expect(team.team_name).to eq("Houston Dynamo")
      expect(team.stadium).to eq("BBVA Stadium")
    end
  end

end