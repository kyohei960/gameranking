class Member::GamesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def index
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @games = @tag.games.order(created_at: :desc)
    else
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
