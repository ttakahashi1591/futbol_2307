require './lib/game'
require './lib/stat_tracker'
# require './lib/team'
# require './lib/game_results'

RSpec.describe StatTracker do
  before(:all) do

    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    # @stat_tracker = StatTracker.new
    @stat_tracker = StatTracker.from_csv(locations)
  end
  
  describe "#initialize" do
    it "exists" do

      expect(@stat_tracker).to be_a(StatTracker)
    end
  end

  describe "#winningest_coach" do
    it "provides coach with the most wins" do
      expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
    end
  end

  describe "#Worst_coach" do
    it "#worst_coach" do
      expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end
  end
end