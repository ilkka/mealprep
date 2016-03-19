(function () {
  'use strict';

  require("basscss/css/basscss.css");
  require("font-awesome/css/font-awesome.css");

  require("./index.html");

  var Elm = require("./Main.elm");
  var mountNode = document.getElementById("app");

  var app = Elm.embed(Elm.Main, mountNode);
})();

