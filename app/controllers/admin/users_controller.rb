class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page])
  end
  
  def destroy
    @user = Game.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
end
