class Public::UsersController < ApplicationController
  def show
    # current_user以外を取得
    # @users = User.all.where.not(id: current_user.id)
    @users = current_user.following_users
    @rooms = current_user.rooms

    # 何かしらのユーザーの検索を行った時
    word = params[:word]
    unless word.nil? || word.blank?
      range = params[:range]
      if range == "Name"
        @users = User.where.not(id: current_user.id).where("name LIKE?", "%#{word}%")
      elsif range == "Nickname"
        @users = User.where.not(id: current_user.id).where("nickname LIKE?", "%#{word}%")
      else
        @users = User.where.not(id: current_user.id).where("search_id LIKE?", "%#{word}%")
      end
    end

    # roomの切り替え処理
    if params[:room_id].present?
      @room = Room.find(params[:room_id])
      # N+1問題を解消するためユーザー情報を含めたルームのメッセージを取得しています（users#showの@messages.eachの中でmessage.userと記述しているためbulletがエラーを出していました）
      @messages = @room.messages.includes(:user)
    end
  end
end
