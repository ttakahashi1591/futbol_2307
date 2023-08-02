require "./lib/league_parser"
require "./lib/team"

RSpec.describe LeagueParser do
  describe "#initialize" do
    it "exists" do
      league_parser = LeagueParser.new("")

      expect(league_parser).to be_a(LeagueParser)
    end
  end 
end