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
  #ゲストログイン用ルーティング設定
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  #ユーザー側のルーティング設定
  scope module: :member do
    root to: "homes#top"
    resources :games, only: [:index, :show] do
      resources :reviews, only: [:index, :create, :destroy]
    end
  end
  #管理者側のルーティング設定
  namespace :admin do
    root to: "homes#top"
    resources :games, only: [:new, :index, :show, :create, :destroy, :edit, :update] do
      resources :reviews, only: [:index, :destroy]
    end

    resources :users, only: [:index, :destroy]
  end
end
