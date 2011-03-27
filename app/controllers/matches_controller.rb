class MatchesController < ApplicationController
  def create
    match = Match.new(params[:match])
    match.save
    redirect_to matches_path
  end

  def index
    @match = Match.new
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def update
    match = Match.find_by_id(params[:id])
    match.update_attributes(params[:match])
    redirect_to matches_path
  end
end