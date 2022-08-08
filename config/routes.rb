Rails.application.routes.draw do
  #管理者用url
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  } 
  #ユーザー用url
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "member/registrations",
    sessions: 'member/sessions'
  }
  #ユーザー側のルーティング設定
  scope module: :member do
    root to: "homes#top"
    resources :games, only: [:index, :show]
  end
  #管理者側のルーティング設定
  namespace :admin do
    root to: "homes#top"
    resources :games, only: [:new, :index, :show, :create, :destroy, :edit]
  end
end
