class Public::UsersController < ApplicationController
  def show
    # current_user以外を取得
    @users = User.all.where.not(id: current_user.id)
    @rooms = current_user.rooms
  end
end
