class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.where.not(email: "guest@example.com").page(params[:page])
  end

  def destroy
    @users = User.find(params[:id])
    @users.destroy
    redirect_to admin_users_path
  end
end
