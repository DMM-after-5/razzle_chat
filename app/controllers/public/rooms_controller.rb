class Public::RoomsController < ApplicationController

  def create
    room = Room.new(room_paarams)
    room.owner_id = current_user.id
    if room.save
      entry = Entry.new(entry_params)
      entry.user_id = current_user.id
      entry.room_id = room.id
      entry.save
      redirect_to root_path
    else
      render root_path
    end
  end

  def destroy
  end

  private

  def room_params
    params.require(:room).permit(:owner_id, :members_status, :name, :introduction, :is_deleteds)
  end

  def entry_params
    params.require(:entry).permit(:user_id, :room_id, :entry_status)
  end

end
