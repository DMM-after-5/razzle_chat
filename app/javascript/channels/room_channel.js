// このファイルは「WebSocket処理のクライアントサイド側」を受け持っています

import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {

  // 接続時のコールバックメソッド
  connected() {
    document.
      querySelector('input[data-behavior="room_speaker"]').
      addEventListener('keypress', (event) => {
        if (event.key === 'Enter') {
          this.speak(event.target.value);
          event.target.value = '';
          return event.preventDefault();
        }
    });
  },

  // 切断時のコールバックメソッド
  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // サーバーからのデータを受信した時のコールバックメソッド
  received(data) {
    const element = document.querySelector('#messages')
    element.insertAdjacentHTML('beforeend', data['message'])
  },

  //
  speak: function(message) {
    // this.perform('speak') はサーバーサイドのspeakメソッドをWebSocket通信経由で呼び出します
    return this.perform('speak', {message: message});
  }
});
