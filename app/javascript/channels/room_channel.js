// このファイルは「WebSocket処理のクライアントサイド側」を受け持っています

import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {

  // 接続時のコールバックメソッド
  connected() {
    // 投稿フォームのメッセージ内容と送信ボタンを取得
    const chatFormText = document.querySelector('textarea[data-behavior="chatFormText"]');
    const chatFormRoomId = document.querySelector('input[data-behavior="chatFormRoomId"]');
    const chatFormSubmit = document.querySelector('input[data-behavior="chatFormSubmit"]');
    // セレクターにidを使わない理由はchatGPTによると・・・
    //   idを使って要素を特定する場合は、同じidを複数の要素に使うことができないため、同じ機能を持った要素を追加する場合に不便です。
    //   一方、data属性を使ったセレクターを使うことで、同じ機能を持った要素を区別することができます。
    //   また、idを使ったセレクターは他のJavaScriptライブラリとの競合を引き起こす可能性があるため、避けるべきです。
    //   したがって、data属性を使ったセレクターを使うことが推奨されます。

    // 送信ボタンがクリックされた時
    chatFormSubmit.addEventListener('click', (event) => {
      // speakメソッドにフォームの内容とroom_idを渡す（サーバーサイドへ送信）
      this.speak(chatFormText.value, chatFormRoomId.value);
      // フォームの文字を消去
      chatFormText.value = '';
      // 通常のフォーム送信を防止
      return event.preventDefault();
    });
  },

  // 切断時のコールバックメソッド
  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // サーバーサイドからのデータを受信するメソッド
  received(data) {
    const element = document.querySelector('#messages')
    element.insertAdjacentHTML('beforeend', data['message'])
  },

  // サーバーサイドへメッセージを送信するメソッド
  speak: function(message, room_id) {
    // this.perform('speak') はサーバーサイドのspeakメソッドをWebSocket通信経由で呼び出します
    // performメソッドを使ってメッセージを送信します
    return this.perform('speak', {message: message, room_id: room_id});
  }
});
