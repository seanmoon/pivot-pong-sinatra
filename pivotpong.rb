require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "haml"

def calculate_ranking
  ranking = []
  File.readlines("data/matches.csv").each do |line|
    line.chomp!
    time, winner, loser = line.split ","

    if !ranking.include? winner
      ranking << winner
    end
    if !ranking.include? loser
      ranking << loser
    end

    winner_index = ranking.index(winner)
    loser_index = ranking.index(loser)

    if winner_index > loser_index
      new_index = (winner_index + loser_index)/2
      ranking.delete_at(winner_index)
      ranking.insert(new_index, winner)
    end
  end
  ranking
end

get "/" do
  @ranking = calculate_ranking
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
