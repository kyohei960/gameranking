class Member::GamesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
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
    @review = Review.new
  end
end
