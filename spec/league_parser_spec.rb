require "./lib/league_parser"
require "./lib/team"

RSpec.describe LeagueParser do
  describe "#initialize" do
    it "exists" do
      league_parser = LeagueParser.new

      expect(league_parser).to be_a(LeagueParser)
    end

    it "has readable attributes" do
      league_parser = LeagueParser.new

      expect(league_parser.teams_list).to eq([])
    end
  end

  describe "#list_teams" do
    it "can return a list of team objects" do
      league_parser = LeagueParser.new

      league_parser.list_teams

      expect(league_parser.teams_list).to be_an(Array)
      expect(league_parser.teams_list.count).to eq(32)
    end
  end
end