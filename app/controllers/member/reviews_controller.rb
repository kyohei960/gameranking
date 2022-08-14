class Member::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
    @game = Game.find(params[:game_id])
    @reviews = @game.reviews
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to game_reviews_path(@review.game)
    else
      @game = Game.find(params[:id])
      render "games/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:game_id, :score, :content)
  end
end
