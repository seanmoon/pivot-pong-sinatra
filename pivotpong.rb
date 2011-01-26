require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "haml"

class PivotPong
  def self.calculate_ranking
    ranking = []
    (File.readlines "data/matches.csv").each do |line|
      line.chomp!
      time, winner, loser = line.split ","
      if (ranking.include?(winner) && ranking.include?(loser))
        # exising winner is ranked ahead of existing loser
        # ranks don't change
        winner_index = ranking.index(winner)
        loser_index = ranking.index(loser)
        if winner_index < loser_index
          puts "skip"
        else
          #both players exist, move up winner
          ranking.delete(winner)
          ranking.insert(loser_index, winner)
        end
      # exising winner is ranked ahead of non-existing loser
      # ranks don't change
      # loser is added to list
      elsif (ranking.include?(winner) && !ranking.include?(loser))
        ranking << loser
      # exising loser, non-existing winner
      # winner takes losers rank
      elsif (!ranking.include?(winner) && ranking.include?(loser))
        index = ranking.index(loser)
        ranking.insert(index,loser)
      else
        # add two new players
          #add winner, loser
        ranking << winner
        ranking << loser
      end
    end
    ranking
  end
end
get "/" do
  @ranking = PivotPong.calculate_ranking
  haml :index
end

get "/history" do
  @history = File.read "data/matches.csv"
  haml :history
end

post "/add-match" do
  winner = params[:winner]
  loser  = params[:loser]
  if !winner.empty? && !loser.empty?
    File.open("data/matches.csv", "a") do |f|
      f.write "#{Time.now},#{winner},#{loser}\n"
    end
  end
  redirect '/'
end
