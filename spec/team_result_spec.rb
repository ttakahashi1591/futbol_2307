require './lib/team_result'

RSpec.describe TeamResult do
  it "Init and get info" do
    tr = TeamResult.new("2012030221", "3", "away", "LOSS", "OT", "John Tortorella", 2, 8, 44, 8, 3, 0, 44.8, 17, 7)
    expect(tr).to be_a TeamResult
    expect(tr.game_id).to eq("2012030221")
    expect(tr.team_id).to eq("3")
  end
end