class Public::RoomsController < ApplicationController

  def create
    room = Room.new(room_params)
    room.owner_id = current_user.id
    if room.save
      entry = Entry.new
      entry.user_id = current_user.id
      entry.room_id = room.id
      entry.save
      redirect_to root_path
    else
      render root_path
    end
  end

  def update
  end

  private

  def room_params
    params.require(:room).permit(:owner_id, :members_status, :name, :introduction, :is_deleted)
  end
end
