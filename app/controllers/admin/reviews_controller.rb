class Admin::ReviewsController < ApplicationController

  def index
    @game = Game.find(params[:game_id])
    @reviews = @game.reviews
  end

  def destroy
    @reviews = Review.find(params[:id])
    @reviews.destroy
    redirect_to admin_game_reviews_path
  end
end