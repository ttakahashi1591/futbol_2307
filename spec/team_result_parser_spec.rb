require './lib/team_result'
require './lib/team_result_parser'
require './lib/game_parser'

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
end