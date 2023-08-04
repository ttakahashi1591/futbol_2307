require './lib/team_result'
require './lib/team_result_parser'
require './lib/league_parser'
require './lib/team'

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

  describe "#scoring_teams" do
    xit "can return #highest_scoring_home_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(highest_scoring_home_team).to eq("Reign FC")
    end

    xit "can return #lowest_scoring_home_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(lowest_scoring_home_team).to eq("Utah Royals FC")
    end

    xit "can return #highest_scoring_visitor" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(highest_scoring_visitor).to eq("FC Dallas")
    end

    xit "can return #lowest_scoring_visitor" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end
  end

  describe "#helper_methods" do
    it "can return #alltime_goals_per_home_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      # expected = {}

      expect(team_result_parser.alltime_goals_per_home_team).to eq(expected)
    end

    xit "can return #alltime_goals_per_visiting_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      # expected = {}

      expect(team_result_parser.alltime_goals_per_visiting_team).to eq(expected)
    end

    xit "can return #home_games_played_per_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      # expected = {}

      expect(team_result_parser.home_games_played_per_team).to eq(expected)
    end

    xit "can return #visiting_games_played_per_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      # expected = {}

      expect(team_result_parser.visiting_games_played_per_team).to eq(expected)
    end

    xit "can return #highest_scoring_home_team_id" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.highest_scoring_home_team_id).to eq(54)
    end

    xit "can return #lowest_scoring_home_team_id" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.lowest_scoring_home_team_id).to eq(7)
    end

    xit "can return #highest_scoring_visiting_team_id" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.highest_scoring_visiting_team_id).to eq(6)
    end

    xit "can return #lowest_scoring_visiting_team_id" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.lowest_scoring_visiting_team_id).to eq(27)
    end
  end
end