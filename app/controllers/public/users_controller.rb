class Public::UsersController < ApplicationController
  def show
    # ActionCable側で current_user のidを取得できるようクッキーにidを保存しています
    # app/channels/application_cable/connection.rb でこのクッキーを呼び出しています
    cookies.signed[:user_id] = current_user.id

    @users = current_user.following_users
    @rooms = current_user.rooms
    @users_follower = current_user.follower_user

    # 何かしらのユーザーの検索を行った時
    word = params[:word]
    unless word.nil? || word.blank?
      range = params[:range]
      # 検索記述省略のため記述内容変更を行った
      @users = User.where.not(id: current_user.id).where.not(id: current_user.following_users.pluck(:id))
      if range == "Name"
        @users.where("name LIKE?", "%#{word}%") 
      elsif range == "Nickname"
        @users.where("nickname LIKE?", "%#{word}%")
      else
        @users.where("search_id LIKE?", "%#{word}%")
      end
    end

    # roomの切り替え処理
    if params[:room_id].present?
      @room = Room.find(params[:room_id])
      # N+1問題を解消するためユーザー情報を含めたルームのメッセージを取得しています（users#showの@messages.eachの中でmessage.userと記述しているためbulletがエラーを出していました）
      @messages = @room.messages.includes(:user).page(params[:page]).per(20)
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
end
