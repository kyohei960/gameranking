class Users::SessionsController < Devise::SessionsController
  #ゲストログイン機能のコントローラー
  def new_guest
    user = User.guest
    sign_in user
    redirect_to games_path, notice: 'ゲストユーザーとしてログインしました！'
  end
end