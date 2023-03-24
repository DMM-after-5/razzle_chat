# このファイルを「チャネル」と呼び、「WebSocket処理のサーバーサイド」を受け持っています
# （クライアント側は app/javascript/channels/room_channel.js）
# チャネルはWebsocket通信におけるコントローラのような役割を果たします
# クライアントはWebsocket通信を通じてチャネルと関連付けされる＝「購読（subscription）」
# 購読は一度に複数のチャネルに対して作ることができ、たとえばチャットルーム用のチャネルと、通知欄用のチャネルを同時に購読するようなことができます

class RoomChannel < ApplicationCable::Channel

  # 購読後に呼び出されるメソッド
  def subscribed
    # 「room_channel」というストリーム名を設定しています
    # 接続しているクライアントへメッセージを送る（ブロードキャスト）時にこのストリーム名を使用します
    # ここではspeakメソッドでブロードキャストする時に使っています
    stream_from "room_channel"
  end

  # 購読解除後に呼び出されるメソッド
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # 購読しているクライアントから呼び出された時に実行されるメソッド
  def speak(data)
    # クライアント側から送られてきたデータ(data)でメッセージのレコードを作ります
    message = Message.create!(message: data["message"], user_id: current_user.id, room_id: data["room_id"])
    # チャネルを購読している人へブロードキャスト！
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
