class Member::GamesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @games = @tag.games.order(created_at: :desc)
    else
      @games = Game.all.order(created_at: :desc)
    end
    @tag_lists = Tag.all
    @games = Kaminari.pagenate_array(@games).page(params[:page]).per(9)
  end

  def show
    @game = Game.find(params[:id])
    @review = Review.new
  end
end
