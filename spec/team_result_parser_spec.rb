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
end