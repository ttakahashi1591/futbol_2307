require './lib/game'
require './lib/game_parser'

RSpec.describe GameParser do
  describe "#Initialize" do  
    it "Exists and gets attributes" do
      game_parser = GameParser.new
      expect(game_parser).to be_a GameParser
      expect(game_parser.games).to eq([])
      game_parser.get_game_info
      # expect(game_parser.games.count).to eq(32)
      expect(game_parser.highest_total_score).to eq(11)
      expect(game_parser.lowest_total_score).to eq(0)
    end
  end
end