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

  scope module: :public do
    resources :members, only: [:index, :show, :edit, :update ]
    get 'members/withdrawl' => 'members#withdrawl'

  end
  # ------

  # ---管理者側---
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }
  # ------

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
