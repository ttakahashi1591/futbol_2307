require './lib/game'
require './lib/stat_tracker'
# require './lib/team'
# require './lib/game_results'

RSpec.describe StatTracker do
  before(:all) do
    # game_path = './data/games.csv'
    # team_path = './data/teams.csv'
    # game_teams_path = './data/game_teams.csv'

    # locations = {
    #   games: game_path,
    #   teams: team_path,
    #   game_teams: game_teams_path
    # }

    # @stat_tracker = StatTracker.from_csv(locations)
  end
  
  describe "#initialize" do
    it "exists" do
      stat_tracker = StatTracker.new

      expect(stat_tracker).to be_a(StatTracker)
    end
  end
end