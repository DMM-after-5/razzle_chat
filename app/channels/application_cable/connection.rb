module ApplicationCable
  class Connection < ActionCable::Connection::Base

    # identified_byメソッドに「:current_user」を渡すと、「current_user」メソッドと「current_user=」メソッドが作成されます
    identified_by :current_user

    # クライアント接続時に呼び出されます
    def connect
      # ログイン中のUserインスタンスをcurrent_userに代入
      self.current_user = find_verified_user
    end

    private

    # クッキーから取得したIDでUserインスタンスを作り、返り値として返しています
    def find_verified_user
      if verified_user = User.find_by(id: cookies.signed[:user_id])
        verified_user
      else
        # クッキーから取得したユーザーIDが見つからなかった時
        # reject_unauthorized_connectionメソッドはWebSocketでの接続を取りやめるためのメソッド
        reject_unauthorized_connection
      end
    end
  end
end
