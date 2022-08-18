class Admin::GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(admin_game_params)
    tag_list = params[:game][:tag_name].split(nil)
    @game.image.attach(params[:game][:image])
    if @game.save
      @game.save_games(tag_list)
      redirect_to admin_games_path(@game.id)
    else
      flash.now[:alert] = '投稿に失敗'
      redirect_to :new
    end
  end

  def index
    @games = Game.page(params[:page])
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    tag_list = params[:game][:tag_name].split(nil)
    if @game.update(admin_game_params)
      @game.update_games(tag_list)
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
