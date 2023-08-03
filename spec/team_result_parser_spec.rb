require './lib/team_result'
require './lib/team_result_parser'

RSpec.describe TeamResultParser do
  describe "#Initialize" do
    it "Exists and gets attribute" do
      team_result_parser = TeamResultParser.new
      expect(team_result_parser).to be_a TeamResultParser
      expect(team_result_parser.game_data_by_team).to eq([])
      team_result_parser.get_game_info
      expect(team_result_parser.game_data_by_team.first.team_id).to eq("3")
    end
  end

  describe "#Averages" do
    it "get average for home wins and away wins and ties" do
      team_result_parser = TeamResultParser.new
      expect(team_result_parser).to be_a TeamResultParser
      team_result_parser.get_game_info
      expect(team_result_parser.percentage_home_wins).to eq(0.44)
      expect(team_result_parser.percentage_visitor_wins).to eq(0.36)
      expect(team_result_parser.percentage_ties).to eq (0.20)
    end
  end
end