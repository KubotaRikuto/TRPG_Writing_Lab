Rails.application.routes.draw do

  namespace :public do
    get 'tags/index'
  end
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
    resources :members, only: [:index, :show, :edit, :update, :destroy]
    get "members/:id/writings" => 'members#writings', as: 'member_writings'
    get "members/:id/like_writings" => 'members#like_writings', as: 'member_like_writings'
    get "members/:id/unsubscribe" => 'members#unsubscribe', as: 'members_unsubscribe'
    # writings
    resources :writings do
      # get 'download'
      resource :writing_likes, only: [:create, :destroy]
      resources :writing_comments, only: [:create, :destroy]
    end
     # search(key_word)
    get 'search' => 'writings#word_search'
    # tags
    resources :tags do
      # search(tag)
      get 'writings' => 'writings#tag_search', as: 'search'
    end

  end
  # ------
  # ------

  # ---管理者側---
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    # members
    resources :members, only: [:index, :show, :edit, :update]
    get "members/:id/writings" => 'members#writings', as: 'member_writings'
    get "members/:id/like_writings" => 'members#like_writings', as: 'member_like_writings'
    # writings
    resources :writings, only: [:index, :show, :update] do
      resources :writing_comments, only: [:destroy]
    end
    #  writing_comments
    resources :writing_comments, only: [:index]
    # search(key_word)
    get 'search' => 'writings#word_search'
    resources :tags, only: [:index, :edit, :create, :update, :destroy] do
      # search(tag)
      get 'writings' => 'writings#tag_search', as: 'search'
    end
  end
  # ------

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
