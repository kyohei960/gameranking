class Member::GamesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    @games = Game.all
  end
  
  def show
    @game = Game.find(params[:id])
    @review = Review.new
  end
end
