class Member::GamesController < ApplicationController
  
  def index
    @games = Game.all
  end
  
  def show
    @game = Game.find(params[:id])
    @review = Review.new
  end
end
