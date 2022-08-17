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

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(admin_game_params)
      redirect_to admin_game_path(@game.id)
    else
      render :edit
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to admin_games_path
  end

  private

  def admin_game_params
    params.require(:game).permit(:title, :image, :body)
  end
end
