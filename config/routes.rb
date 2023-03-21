Rails.application.routes.draw do
  # 以下各種機能を入れていく
  scope module: :public do
    resource :users, only: [:update] do
      resource :relationships, only: [:create, :destroy]
    end
    resources :rooms, only: [:create, :update]
    resources :entries, only: [:create, :update, :destroy]
    resources :messages, only: [:create, :destroy]
    post 'create_all' => 'entries#create_all'

  end
  # deviseの機能
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  # userがログインしている時のrootページ
  authenticated :user do
    root "public/users#show", as: :authenticated_root  # Pathは一意でなければならないため被らないように名前をつける
  end

  # 未ログイン時のrootページ
  devise_scope :user do
    root 'public/sessions#new'
  end


end
