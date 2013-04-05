@Bridge.DirectionController = Ember.Controller.extend
  needs: ["table"]

  currentBinding: "controllers.table.board.currentDirection"
