require 'spec_helper'

RSpec.describe Game do
  it "Initialize and get info" do
    game = Game.new("2012030221", "20122013", 3, 6, 2, 3)
    expect(game).to be_a Game
    expect(game.game_id).to eq("2012030221")
    expect(game.season).to eq("20122013")
  end
end