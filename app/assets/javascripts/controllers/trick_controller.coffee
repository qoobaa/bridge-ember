@Bridge.TrickController = Ember.ArrayController.extend
  needs: ["board"]

  contentBinding: "controllers.board.tricks.lastObject"
