class Public::EntriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_to root_path
    else
      #userのshowで必要な変数をすべて此処に記述
      render root_path
    end
  end

  def create_all
    @room = Room.find(params[:entry][:room_id])
    number = Entry.where(room_id: @room.id).length + params[:user_ids].length
    if number > @room.members_status.to_i
      if @room.owner_id == current_user.id
        @room.update(members_status: number)
      else
        redirect_to root_path, alert: "招待に失敗しました(人数をオーバーしています)"
        return
      end
    end
    params[:user_ids].each do |user_id|
      @entry = Entry.new(entry_params)
      @entry.user_id = user_id
      if @entry.save

      else
        #userのshowで必要な変数をすべて此処に記述
        render root_path
      end
    end
    redirect_to root_path
  end

  def update
    entry = Entry.find(params[:id])
    if entry.update(entry_status: true)
      redirect_to root_path
    else
      #userのshowで必要な変数をすべて此処に記述
      render root_path
    end
  end

  def destroy
    entry = Entry.find(params[:id])
    entry.destroy!
    redirect_to root_path
  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :room_id)
  end
end
