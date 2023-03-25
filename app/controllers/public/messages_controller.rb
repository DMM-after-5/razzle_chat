class Public::MessagesController < ApplicationController

  def create
    @message = current_user.messages.new(message_params)
    @message.save
    # redirect_to request.referer
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
    params.require(:message).permit(:message,:room_id,:user_id)
  end

end
