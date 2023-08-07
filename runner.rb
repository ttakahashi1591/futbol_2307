require './lib/stat_tracker'

game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

@stat_tracker = StatTracker.from_csv(locations)

puts "Welcome to Futbol for class 2307"
puts "Please enter season with the starting year:"
year_entered = gets.chomp

if year_entered.is_a? String
  if year_entered == "data"
    puts "Pulling data, please be patient"
    puts "Highest total score: #{@stat_tracker.highest_total_score}"
    puts "Lowest total score: #{@stat_tracker.lowest_total_score}"
    puts "Home wins percent: #{@stat_tracker.percentage_home_wins}"
    puts "Vistor wins percent: #{@stat_tracker.percentage_visitor_wins}"
    puts "Percent of ties: #{@stat_tracker.percentage_ties}"
    puts "Count of games played per season: #{@stat_tracker.count_of_games_by_season}"
    puts "Average goals per game: #{@stat_tracker.average_goals_per_game}"
    puts "Average goals per season: #{@stat_tracker.average_goals_by_season}"
    puts "Count of teams: #{@stat_tracker.count_of_teams}"
    puts "Best offense: #{@stat_tracker.best_offense}"
    puts "Worst offense: #{@stat_tracker.worst_offense}"
    puts "Highest scoring visitor: #{@stat_tracker.highest_scoring_visitor}"
    puts "Highest scoring home team: #{@stat_tracker.highest_scoring_home_team}"
    puts "Lowest scoring visitor: #{@stat_tracker.lowest_scoring_visitor}"
    puts "Lowest scoring home team: #{@stat_tracker.lowest_scoring_home_team}"
  elsif year_entered.to_i >= 2012 && year_entered.to_i < 2018
    other_half = year_entered.to_i
    other_half += 1
    season_year = year_entered + other_half.to_s
    puts "Coach with most wins: #{@stat_tracker.winningest_coach(season_year)}"
    puts "Coach with least wins: #{@stat_tracker.worst_coach(season_year)}"
    puts "Most accurate team: #{@stat_tracker.most_accurate_team(season_year)}"
    puts "Least accurate team: #{@stat_tracker.least_accurate_team(season_year)}"
    puts "Team with most tackles: #{@stat_tracker.most_tackles(season_year)}"
    puts "Team with fewest tackles: #{@stat_tracker.fewest_tackles(season_year)}"
  else
   puts "Not a good year"
  end
else
  puts "Not a usable number"
end