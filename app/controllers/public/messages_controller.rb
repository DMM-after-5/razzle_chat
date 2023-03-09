class Public::MessagesController < ApplicationController

  def create
    room = Room.find(params[:room_id])
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @message.room_id = room.id
    @message.save
    redirect_to request.referer
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.user_id == current_user.id
      Message.find(params[:id]).destroy
    end
    redirect_to request.referer
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end

end
