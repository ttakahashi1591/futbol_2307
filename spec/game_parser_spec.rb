require 'spec_helper'

RSpec.describe GameParser do
  before(:all) do
    @game_path = './data/games.csv'
  end

  describe "#Initialize" do  
    it "Exists and gets attributes" do
      game_parser = GameParser.new

      expect(game_parser).to be_a GameParser
      expect(game_parser.games).to eq([])

      game_parser.get_game_info(@game_path)

      expect(game_parser.highest_total_score).to eq(11)
      expect(game_parser.lowest_total_score).to eq(0)
    end
  end

  describe "#Highest and Lowest" do  
    it "get the highest and lowest total scores" do
      game_parser = GameParser.new

      expect(game_parser).to be_a GameParser

      game_parser.get_game_info(@game_path)

      expect(game_parser.highest_total_score).to eq(11)
      expect(game_parser.lowest_total_score).to eq(0)
    end
  end

  describe "#Count" do  
    it "count of game per season" do
      game_parser = GameParser.new

      expect(game_parser).to be_a GameParser

      game_parser.get_game_info(@game_path)
      
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    expect(game_parser.count_of_games_by_season).to eq (expected)
    end
  end

  describe "#Average" do  
    it "goals per game and season" do
      game_parser = GameParser.new

      expect(game_parser).to be_a GameParser

      game_parser.get_game_info(@game_path)
      
      expect(game_parser.average_goals_per_game).to eq (4.22)
  
      expected = {
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
      }
      expect(game_parser.average_goals_by_season).to eq (expected)
    end
  end
end