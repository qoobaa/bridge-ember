@Bridge.HandController = Ember.ArrayController.extend
  needs: ["board"]

  playedCardsBinding: "controllers.board.cards"
  isCompletedBinding: "controllers.board.isPlayCompleted"
  currentDirectionBinding: "controllers.board.currentPlayDirection"
  currentSuitBinding: "controllers.board.currentSuit"

  play: (card) ->
    @get("controllers.board.cards").pushObject(card)

Bridge.register "controller:hand_n", Bridge.HandController.extend
  contentBinding: "controllers.board.n"
  direction: "N"

Bridge.register "controller:hand_e", Bridge.HandController.extend
  contentBinding: "controllers.board.e"
  direction: "E"

Bridge.register "controller:hand_s", Bridge.HandController.extend
  contentBinding: "controllers.board.s"
  direction: "S"

Bridge.register "controller:hand_w", Bridge.HandController.extend
  contentBinding: "controllers.board.w"
  direction: "W"
