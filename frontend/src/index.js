(function () {
  'use strict';

  require("basscss/css/basscss.css");
  require("basscss-colors/css/colors.css");
  require("basscss-background-colors/css/background-colors.css");
  require("basscss-btn/css/btn.css");
  require("basscss-btn-primary/css/btn-primary.css");
  require("font-awesome/css/font-awesome.css");

  require("./index.html");

  var Elm = require("./Main.elm");
  var mountNode = document.getElementById("app");

  var app = Elm.embed(Elm.Main, mountNode);
})();
