// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// jquery,popper.js,bootstrap,fontawesomeを追加
import "jquery"; // @^3.7.0

import '@popperjs/core'
import "bootstrap"; // @^5.2.3
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all' // @6.4.0
import "../stylesheets/mystyle.css" // オリジナルCSS

Rails.start()
Turbolinks.start()
ActiveStorage.start()
