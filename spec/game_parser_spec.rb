require './lib/game'
require './lib/game_parser'

RSpec.describe GameParser do
  it "Init and get info" do
    game_parser = GameParser.new
    expect(game_parser).to be_a GameParser
    expect(game_parser.games).to eq([])
    game_parser.get_game_info
    expect(game_parser.games.count).to eq(32)
  end
end