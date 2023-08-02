require './lib/game'
require './lib/stat_tracker'
# require './lib/team'
# require './lib/game_results'

RSpec.describe StatTracker do
  describe "#initialize" do
    it "initialize" do
      stat_tracker = StatTracker.new

      expect(stat_tracker).to be_a(StatTracker)
    end
  end
end