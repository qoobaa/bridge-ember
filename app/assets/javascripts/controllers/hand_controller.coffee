@Bridge.HandController = Ember.ArrayController.extend
  needs: ["board"]

  playedCardsBinding: "controllers.board.cards"
  isCompletedBinding: "controllers.board.isPlayCompleted"
  currentDirectionBinding: "controllers.board.currentPlayDirection"
  currentSuitBinding: "controllers.board.currentSuit"

  cardsLeft: (->
    @get("content").filter (card) =>
      not @get("playedCards").contains(card)
  ).property("playedCards.@each")

  hasCardInCurrentSuit: (->
    suitsLeft = @get("cardsLeft").map((card) -> card[0]).uniq()
    suitsLeft.contains @get("currentSuit")
  ).property("cardsLeft.@each", "currentSuit")

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
