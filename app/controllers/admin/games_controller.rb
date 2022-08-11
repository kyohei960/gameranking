class Admin::GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(admin_game_params)
    if @game.save
      redirect_to admin_games_path(@game.id)
    else
      redirect_to :new
    end
  end
  
  def index
    @games = Game.all
  end
  
  def show
    @game = Game.find(params[:id])
  end

  private

  def admin_game_params
    params.require(:game).permit(:title, :image, :body)
  end
end
