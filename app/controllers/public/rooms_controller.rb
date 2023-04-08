class Public::RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_room, only: [:update]

  def create
    room = Room.new(room_params)
    room.owner_id = current_user.id
    if room.save
      entry = Entry.new
      entry.user_id = current_user.id
      entry.room_id = room.id
      entry.entry_status = true
      entry.save
      # 新規立ち上げのメッセージの作成
      # message = current_user.messages.new
      # message.message = "新しくルームを作成しました"
      # message.room_id = room.id
      # message.save
      redirect_to root_path(room_id: params[:room_id])
    else
      render root_path
    end
  end

  def update
    room = Room.find(params[:id])
    if room.update(room_params)
      redirect_to root_path(room_id: room.id)
    else
      render root_path(room_id: room.id)
    end
  end

  private

  def room_params
    params.require(:room).permit(:owner_id, :members_status, :name, :introduction, :is_deleted)
  end

  def ensure_room
    room = Room.find(params[:id])
    unless room.owner_id == current_user.id
      redirect_to root_path, alert: 'ルームのオーナーのみ編集可能です'
    end
  end
end
