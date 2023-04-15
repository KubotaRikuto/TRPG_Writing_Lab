Rails.application.routes.draw do

  # TOPページ
  root to: 'public/homes#top'

  # ---会員側---
  # devise機能
  devise_for :members , controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions',
    passwords: 'public/passwords'
  }

  devise_scope :member do
    # ゲストログイン
    post '/member/guest_sign_in' => 'public/sessions#new_guest'
  end

  scope module: :public do
    # members
    resources :members, only: [:index, :show, :edit, :update ]
    patch 'members/withdrawl/:id' => 'members#withdrawl', as: 'members_withdrawl'
    # works
    resources :works

  end
  # ------

  # ---管理者側---
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }
  # ------

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
