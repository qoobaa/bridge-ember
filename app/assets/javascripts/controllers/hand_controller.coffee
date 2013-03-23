@Bridge.HandController = Ember.ArrayController.extend
  needs: ["board"]

  playedCardsBinding: "controllers.board.cards"
  isStartedBinding: "controllers.board.isAuctionCompleted"
  isCompletedBinding: "controllers.board.isPlayCompleted"
  currentDirectionBinding: "controllers.board.currentPlayDirection"
  currentSuitBinding: "controllers.board.currentSuit"

  cardsLeft: (->
    @get("content").reject (card) => @get("playedCards").contains(card)
  ).property("playedCards.@each")

  hasCardInCurrentSuit: (->
    suitsLeft = @get("cardsLeft").map((card) -> card[0]).uniq()
    suitsLeft.contains @get("currentSuit")
  ).property("cardsLeft.@each", "currentSuit")

  content: (->
    Bridge.Utils.sortCards(@get("initial"))
  ).property("initial.@each")

  sortingCardsObserver: (->
    if trump = @get("controllers.board.trump") # No need for sorting when NT
      @set "content", Bridge.Utils.sortCards(@get("content"), trump)
  ).observes("isStarted")

  play: (card) ->
    @get("controllers.board.cards").pushObject(card)

Bridge.register "controller:hand_n", Bridge.HandController.extend
  initialBinding: "controllers.board.n"
  direction: "N"

Bridge.register "controller:hand_e", Bridge.HandController.extend
  initialBinding: "controllers.board.e"
  direction: "E"

Bridge.register "controller:hand_s", Bridge.HandController.extend
  initialBinding: "controllers.board.s"
  direction: "S"

Bridge.register "controller:hand_w", Bridge.HandController.extend
  initialBinding: "controllers.board.w"
  direction: "W"
