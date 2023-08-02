require './lib/team_result'
require './lib/team_result_parser'

RSpec.describe TeamResultParser do
  it "Init and get info" do
    team_result_parser = TeamResultParser.new
    expect(team_result_parser).to be_a TeamResultParser
    expect(team_result_parser.game_data_by_team).to eq([])
    team_result_parser.get_game_info
    expect(team_result_parser.game_data_by_team.first.team_id).to eq("3")
  end
end