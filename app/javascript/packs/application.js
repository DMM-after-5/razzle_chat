// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'


Rails.start()
Turbolinks.start()
ActiveStorage.start()



// クッキー機能未実装

// window.Cookies = require("js-cookie")
//
// // $(document).on('turbolinks:load', function() {
// // $(document).ready(function() {
// //   console.log("test");
// //   $(function() {
//
// //     $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
//
// //       //console.log(e.target.href);
// //       var tabName = e.target.href;
// //       var items = tabName.split("#");
// //       Cookies.set("openTag",items[1], { expires: 1/24 });
// //     });
//
// //     if(Cookies.get("openTag")){
// //       $('a[data-toggle="tab"]').parent().removeClass('active');
// //       $('a[href="#' + Cookies.get("openTag") +'"]').click();
// //     }
// //   });
// //});
//
// // Cookies.set('openTag', "friends");
//
// let test1 = Cookies.get("openTag");
//
// $(document).on('turbolinks:load', function() {
//
//
//   $('a[data-toggle="tab"]').on('click', function (e) {
//     var tabName = e.target.href;
//     var items = tabName.split("#");
//
//     Cookies.set("openTag",items[1], { expires: 1/24 });
//
//     // Cookiesの"openTag"にfriendが入っているが、roomが入らない
//     test1 = Cookies.get("openTag");
//     console.log(Cookies.get("openTag"));
//   });
//
//   // if(Cookies.get("openTag")) {では if文が正常に動作していない？
//   //  console.log("openTag if 開始");が作動しなかった。if(test1.present) { なら問題なく稼働する。尚、クリックイベントは動作しない。
//   //----------------------------------------------------------
//   //if(Cookies.get("openTag")) {
//   //if(test1.present) {
//   //
//   //} else {
//   //  console.log("openTag if 開始");
//   //  console.log(test1);
//   //  $('a[data-toggle="tab"]').parent().removeClass('active');
//   //
//   //  // 下記コードでactive取り付け可能
//   //  // ただし、表示内容がroomのものになっている
//   //  //$('a[href="#' + Cookies.get("openTag") +'"]').addClass('active');
//   //
//   //  // クリック処理のみ未実装
//   //  //$('#friends').trigger("click");
//   //  $('a[href="#' + Cookies.get("openTag") +'"]').click();
//   //  // $('a[href="#' + Cookies.get("openTag") +'"]').click();
//   //};
//
//
//   // 新規記述
//   if(test1.to_s == "friends") {
//
//   } else {
//     //console.log("openTag if 開始");
//     //console.log(test1);
//     $('#rooms-tab').removeClass('active');
//     $('#friends-tab').click();
//
//
//
//     // 下記コードでactive取り付け可能
//     // ただし、表示内容がroomのものになっている
//     //$('a[href="#' + Cookies.get("openTag") +'"]').addClass('active');
//
//     // クリック処理のみ未実装
//     //$('#friends').trigger("click");
//     //$('a[href="#' + Cookies.get("openTag") +'"]').click();
//     // $('a[href="#' + Cookies.get("openTag") +'"]').click();
//   };
// });