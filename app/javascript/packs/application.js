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

import Cookies from 'js-cookie';

Rails.start()
Turbolinks.start()
ActiveStorage.start()

window.Cookies = require("js-cookie")

// $(document).on('turbolinks:load', function() {
// $(document).ready(function() {
//   console.log("test");
//   $(function() {
    
//     $('a[data-toggle="tab"]').on('show.bs.tab', function (e) {
      
//       //console.log(e.target.href);
//       var tabName = e.target.href;
//       var items = tabName.split("#");
//       Cookies.set("openTag",items[1], { expires: 1/24 });
//     });

//     if(Cookies.get("openTag")){
//       $('a[data-toggle="tab"]').parent().removeClass('active');
//       $('a[href="#' + Cookies.get("openTag") +'"]').click();
//     }
//   });
//});

// Cookies.set('openTag', "friends");

$(document).on('turbolinks:load', function() {
  
  
  $('a[data-toggle="tab"]').on('click', function (e) {
    var tabName = e.target.href;
    var items = tabName.split("#");
    Cookies.set("openTag",items[1], { expires: 1/24 });
    console.log(Cookies.get("openTag"));
  });


  if(Cookies.get("openTag") == "friends") {
    console.log(Cookies.get("openTag if 開始"));
    $('a[data-toggle="tab"]').parent().removeClass('active');
    
    // 下記コードでactive取り付け可能
    // ただし、表示内容がroomのものになっている
    //$('a[href="#' + Cookies.get("openTag") +'"]').addClass('active');
    
    // クリック処理のみ未実装
    //$('#friends').trigger("click");
    $('a[href="#' + Cookies.get("openTag") +'"]').click();
    // $('a[href="#' + Cookies.get("openTag") +'"]').click();
  }
});