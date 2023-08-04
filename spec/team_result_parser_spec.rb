require './lib/team_result'
require './lib/team_result_parser'
require './lib/game_parser'
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

  describe "#get_win_percentage" do
    it "provides a hash with coach and win percentage" do
      team_result_parser = TeamResultParser.new
      team_result_parser.get_game_info

      game_parser = GameParser.new
      game_parser.get_game_info
      season_hash = game_parser.get_season_games("20132014")
      season_games = season_hash[true]
      expect(team_result_parser.get_win_percentage(season_games)).to be_a(Hash)
    end
  end

  describe "#get_win_games_from_season" do
    it "provides a string with the coach with the highest percentage" do
      team_result_parser = TeamResultParser.new
      team_result_parser.get_game_info

      game_parser = GameParser.new
      game_parser.get_game_info
      season_hash = game_parser.get_season_games("20132014")
      season_games = season_hash[true]
  
      expect(team_result_parser.get_win_games_from_season(season_games)).to eq("Claude Julien")
    end
  end

  describe "#get_lose_games_from_season" do
    it "provides a string with the coach with the lowest percentage" do
      team_result_parser = TeamResultParser.new
      team_result_parser.get_game_info

      game_parser = GameParser.new
      game_parser.get_game_info
      season_hash = game_parser.get_season_games("20132014")
      season_games = season_hash[true]

      expect(team_result_parser.get_lose_games_from_season(season_games)).to eq("Peter Laviolette")
    end
  end

  describe "#offense" do
    it "can find the best and worst offenses" do
      league_parser = LeagueParser.new
      team_result_parser = TeamResultParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.best_offense(league_parser.teams_list)).to eq("Reign FC")
      expect(team_result_parser.worst_offense(league_parser.teams_list)).to eq("Utah Royals FC")
    end
  end

  describe "#helper_method" do
    it "can return #alltime_goals_per_team" do
      team_result_parser = TeamResultParser.new

      team_result_parser.get_game_info

      expected = {1=>896,
                  2=>1053,
                  3=>1129,
                  4=>972,
                  5=>1262,
                  6=>1154,
                  7=>841,
                  8=>1019,
                  9=>1038,
                  10=>1007,
                  12=>936,
                  13=>955,
                  14=>1159,
                  15=>1168,
                  16=>1156,
                  17=>1007,
                  18=>1101,
                  19=>1068,
                  20=>978,
                  21=>973,
                  22=>964,
                  23=>923,
                  24=>1146,
                  25=>1061,
                  26=>1065,
                  27=>263,
                  28=>1128,
                  29=>1029,
                  30=>1062,
                  52=>1041,
                  53=>620,
                  54=>239}

      expect(team_result_parser.alltime_goals_per_team).to eq(expected)
    end

    it "can find the #games_played_per_team" do
      team_result_parser = TeamResultParser.new

      team_result_parser.get_game_info

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

      expect(team_result_parser.games_played_per_team).to eq(expected)
    end

    it "can find_best_offense_team_id" do
      team_result_parser = TeamResultParser.new

      team_result_parser.get_game_info

      expect(team_result_parser.find_best_offense_team_id).to eq(54)
    end

    it "can find_best_worst_team_id" do
      team_result_parser = TeamResultParser.new

      team_result_parser.get_game_info

      expect(team_result_parser.find_worst_offense_team_id).to eq(7)
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

    it "can return #lowest_scoring_home_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.lowest_scoring_home_team(league_parser.teams_list)).to eq("Utah Royals FC")
    end

    it "can return #highest_scoring_visitor" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.highest_scoring_visitor(league_parser.teams_list)).to eq("FC Dallas")
    end

    it "can return #lowest_scoring_visitor" do
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

    it "can return #alltime_goals_per_visiting_team" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expected = {1=>440,
                  2=>507,
                  3=>572,
                  4=>470,
                  5=>598,
                  6=>568,
                  7=>430,
                  8=>500,
                  9=>498,
                  10=>469,
                  12=>462,
                  13=>453,
                  14=>550,
                  15=>582,
                  16=>558,
                  17=>504,
                  18=>527,
                  19=>519,
                  20=>458,
                  21=>450,
                  22=>479,
                  23=>453,
                  24=>553,
                  25=>505,
                  26=>519,
                  27=>120,
                  28=>549,
                  29=>505,
                  30=>506,
                  52=>488,
                  53=>303,
                  54=>107}

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

    it "can return #visiting_games_played_per_team" do
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

      expect(team_result_parser.visiting_games_played_per_team).to eq(expected)
    end

    it "can return #highest_scoring_home_team_id" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.highest_scoring_home_team_id).to eq(54)
    end

    it "can return #lowest_scoring_home_team_id" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.lowest_scoring_home_team_id).to eq(7)
    end

    it "can return #highest_scoring_visiting_team_id" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.highest_scoring_visiting_team_id).to eq(6)
    end

    it "can return #lowest_scoring_visiting_team_id" do
      team_result_parser = TeamResultParser.new
      league_parser = LeagueParser.new

      team_result_parser.get_game_info
      league_parser.list_teams

      expect(team_result_parser.lowest_scoring_visiting_team_id).to eq(27)
    end
  end
end