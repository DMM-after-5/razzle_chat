class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # room_idを渡したい・・
    message = Message.create!(message: data["message"], user_id: current_user.id, room_id: 1)
    ActionCable.server.broadcast(
      "room_channel", { message: data["message"] }
    )
  end

  private

  def render_message(message)
    ApplicationController.render(
      partial: "public/messages/message",
      locals: { messages: @messages }
    )
  end
end
