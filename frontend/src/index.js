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

  var app = Elm.embed(Elm.Main, mountNode, {getDeleteConfirmation: 0});

  app.ports.askDeleteConfirmation.subscribe(function (args) {
    console.log('askDeleteConfirmation', args);
    var id = args[0];
    var message = args[1];
    var response = window.confirm(message);
    if (response) {
      app.ports.getDeleteConfirmation.send(id);
    }
  });
})();
