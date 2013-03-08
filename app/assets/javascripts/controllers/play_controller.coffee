@Bridge.PlayController = Ember.Controller.extend
  needs: ["board"]

  contentBinding: "controllers.board.play"
  declarerBinding: "controllers.board.declarer"
