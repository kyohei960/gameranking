class Member::GamesController < ApplicationController
  def index
    @games = Game.all
  end
  
  def show
    @game = Game.find(params[:id])
    @game_comment = GameComment.new
    @games = Game.new
  end
end
