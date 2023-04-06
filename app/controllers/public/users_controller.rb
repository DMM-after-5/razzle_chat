class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_room, only: [:show]

  def show
    # ActionCable側で current_user のidを取得できるようクッキーにidを保存しています
    # app/channels/application_cable/connection.rb でこのクッキーを呼び出しています
    cookies.signed[:user_id] = current_user.id

    # フレンド一覧 兼 検索結果一覧
    @users = current_user.following_users
    # ルーム一覧
    @rooms = current_user.rooms
    
    # メッセージ投稿された順にルームを並び替える
    # @rooms = current_user.rooms.sort_by { |room| room.messages&.last&.created_at }.reverse
    
    # 自分をフォローしている人
    @users_follower = current_user.follower_user
    # 相互フォローの人
    @mutual_follows = @users & @users_follower

    # 何かしらのユーザーの検索を行った時
    @word = params[:word]
    unless @word.nil? || @word.blank?
      range = params[:range]
      # 検索記述省略のため記述内容変更を行った
      @users = User.where.not(id: current_user.id).where.not(id: current_user.following_users.pluck(:id))
      if range == "Nickname"
        @users = @users.where("nickname LIKE?", "%#{@word}%")
      else
        @users = @users.where("search_id LIKE?", "#{@word}")
      end
    end
    
    # 何かしらのメッセージの検索を行った時
    @search_message = params[:message_search_word]
    unless @search_message.nil? || @search_message.blank?
      @search_messages = Message.where(room_id: params[:room_id]).includes(:user).where("message LIKE?", "%#{@search_message}%")
    end

    # roomの切り替え処理
    if params[:room_id].present?
      # N+1問題を解消するためユーザー情報を含めたルームのメッセージを取得しています（users#showの@messages.eachの中でmessage.userと記述しているためbulletがエラーを出していました）
      # @room（ルームのレコード）はensure_roomメソッドで取得しております
      @messages = @room.messages.includes(:user)
      # @messages = @room.messages.includes(:user).page(params[:page]).per(20)
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      @users = current_user.following_users
      @rooms = current_user.rooms
      flash.now[:alert] = "ユーザー情報の編集に失敗しました"
      render :show
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :nickname, :phone_number, :search_id, :email)
  end

  # 招待済みのルームか確認するためのメソッド
  def ensure_room
    if params[:room_id].present?
      @room = Room.find(params[:room_id])
      unless @room.users.any?{ |user| user == current_user }
        redirect_to root_path, alert: 'このルームには入れません'
      end
    end
  end
end
