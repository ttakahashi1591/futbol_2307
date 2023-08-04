require './lib/game_parser'
require './lib/stat_tracker'
require './lib/team_result_parser'
require './lib/league_parser'

RSpec.describe StatTracker do
  before(:all) do

    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end
  
  describe "#initialize" do
    it "exists" do

      expect(@stat_tracker).to be_a(StatTracker)
    end
  end

  describe "#winningest_coach" do
    it "provides coach with the most wins" do
      expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
    end
  end

  describe "#Worst_coach" do
    it "#worst_coach" do
      expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end
  end

  # it "#highest_total_score" do
  #   expect(@stat_tracker.highest_total_score).to eq 11
  # end

  # it "#lowest_total_score" do
  #   expect(@stat_tracker.lowest_total_score).to eq 0
  # end

  # it "#percentage_home_wins" do
  #   expect(@stat_tracker.percentage_home_wins).to eq 0.44
  # end

  # it "#percentage_visitor_wins" do
  #   expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
  # end

  # it "#percentage_ties" do
  #   expect(@stat_tracker.percentage_ties).to eq 0.20
  # end

  # it "#count_of_games_by_season" do
  #   expected = {
  #     "20122013"=>806,
  #     "20162017"=>1317,
  #     "20142015"=>1319,
  #     "20152016"=>1321,
  #     "20132014"=>1323,
  #     "20172018"=>1355
  #   }
  #   expect(@stat_tracker.count_of_games_by_season).to eq expected
  # end

  # it "#average_goals_per_game" do
  #   expect(@stat_tracker.average_goals_per_game).to eq 4.22
  # end

  # it "#average_goals_by_season" do
  #   expected = {
  #     "20122013"=>4.12,
  #     "20162017"=>4.23,
  #     "20142015"=>4.14,
  #     "20152016"=>4.16,
  #     "20132014"=>4.19,
  #     "20172018"=>4.44
  #   }
  #   expect(@stat_tracker.average_goals_by_season).to eq expected
  # end

  # it "#count_of_teams" do
  #   expect(@stat_tracker.count_of_teams).to eq 32
  # end

  # it "#best_offense" do
  #   expect(@stat_tracker.best_offense).to eq "Reign FC"
  # end

  # it "#worst_offense" do
  #   expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  # end

  # it "#highest_scoring_visitor" do
  #   expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  # end

  # it "#highest_scoring_home_team" do
  #   expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  # end

  # it "#lowest_scoring_visitor" do
  #   expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  # end

  # it "#lowest_scoring_home_team" do
  #   expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  # end

  # it "#team_info" do
  #   expected = {
  #     "team_id" => "18",
  #     "franchise_id" => "34",
  #     "team_name" => "Minnesota United FC",
  #     "abbreviation" => "MIN",
  #     "link" => "/api/v1/teams/18"
  #   }

  #   expect(@stat_tracker.team_info("18")).to eq expected
  # end

  # it "#best_season" do
  #   expect(@stat_tracker.best_season("6")).to eq "20132014"
  # end

  # it "#worst_season" do
  #   expect(@stat_tracker.worst_season("6")).to eq "20142015"
  # end

  # it "#average_win_percentage" do
  #   expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
  # end

  # it "#most_goals_scored" do
  #   expect(@stat_tracker.most_goals_scored("18")).to eq 7
  # end

  # it "#fewest_goals_scored" do
  #   expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
  # end

  # it "#favorite_opponent" do
  #   expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
  # end

  # it "#rival" do
  #   expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
  # end
end