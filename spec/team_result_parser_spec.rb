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
    it "can return #highest_scoring_home_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.highest_scoring_home_team(league_parser.teams_list)).to eq("Reign FC")
    end

    xit "can return #lowest_scoring_home_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.lowest_scoring_home_team(league_parser.teams_list)).to eq("Utah Royals FC")
    end

    xit "can return #highest_scoring_visitor" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.highest_scoring_visitor(league_parser.teams_list)).to eq("FC Dallas")
    end

    xit "can return #lowest_scoring_visitor" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.lowest_scoring_visitor(league_parser.teams_list)).to eq("San Jose Earthquakes")
    end
  end

  describe "#helper_methods" do
    it "can return #alltime_goals_per_home_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expected = {1=>456,
                  2=>546,
                  3=>557,
                  4=>502,
                  5=>664,
                  6=>586,
                  7=>411,
                  8=>519,
                  9=>540,
                  10=>538,
                  12=>474,
                  13=>502,
                  14=>609,
                  15=>586,
                  16=>598,
                  17=>503,
                  18=>574,
                  19=>549,
                  20=>520,
                  21=>523,
                  22=>485,
                  23=>470,
                  24=>593,
                  25=>556,
                  26=>546,
                  27=>143,
                  28=>579,
                  29=>524,
                  30=>556,
                  52=>553,
                  53=>317,
                  54=>132}

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

    it "can return #home_games_played_per_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expected = {1=>463,
                  2=>482,
                  3=>531,
                  4=>477,
                  5=>552,
                  6=>510,
                  7=>458,
                  8=>498,
                  9=>493,
                  10=>478,
                  12=>458,
                  13=>464,
                  14=>522,
                  15=>528,
                  16=>534,
                  17=>489,
                  18=>513,
                  19=>507,
                  20=>473,
                  21=>471,
                  22=>471,
                  23=>468,
                  24=>522,
                  25=>477,
                  26=>511,
                  27=>130,
                  28=>516,
                  29=>475,
                  30=>502,
                  52=>479,
                  53=>328,
                  54=>102}

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

    it "can return #highest_scoring_home_team_id" do
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