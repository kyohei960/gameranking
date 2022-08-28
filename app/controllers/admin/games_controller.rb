class Admin::GamesController < ApplicationController
  before_action :authenticate_admin!

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(admin_game_params)
    tag_list = params[:game][:tag_name].split(/[[:blank:]]/)
    @game.image.attach(params[:game][:image])
    if @game.save
      @game.save_games(tag_list)
      redirect_to admin_games_path
    else
      flash.now[:alert] = '投稿に失敗'
      render :new
    end
  end

  def index
    #タグで絞り込まれた場合
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @games = @tag.games.order(created_at: :desc)
    #ジャンルで検索された場合
    elsif params[:genre] != nil
      @games = Game.where(genre_id: params[:genre])
    else
      #評価が高い順に並べるようにするため
      @games = Game.
              left_joins(:reviews).
              distinct.
              sort_by do |game|
                hoges = game.reviews
                if hoges.present?
                  hoges.map(&:score).sum / hoges.size
                else
                  0
                end
              end.
              reverse
    end
    @tag_lists = Tag.all
    @games = Kaminari.paginate_array(@games).page(params[:page]).per(9)
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
    params.require(:game).permit(:title, :image, :body, :genre_id)
  end
end
