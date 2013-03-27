@Bridge.HandController = Ember.ArrayController.extend
  init: ->
    @_super.apply(@, arguments)
    @set("play", Bridge.Play.create(content: [], contract: "4NT"))

  # playedBinding: "controllers.board.cards"
  # playedDirectionsBinding: "controllers.board.playDirections"
  # isStartedBinding: "controllers.board.isAuctionCompleted"
  # isCompletedBinding: "controllers.board.isBoardCompleted"
  # currentDirectionBinding: "controllers.board.currentPlayDirection"
  # currentSuitBinding: "controllers.board.currentSuit"
  # trumpBinding: "controllers.board.trump"

  # hasCardInCurrentSuit: (->
  #   suitsLeft = @get("content").map((card) -> card[0]).uniq()
  #   suitsLeft.contains(@get("currentSuit"))
  # ).property("content.@each", "currentSuit")

  # content: (->
  #   if @get("initial.length")
  #     remaining = @get("initial").reject (card) => @get("played").contains(card)
  #     # Bridge.Utils.sortCards(remaining, @get("trump"))
  #   else
  #     playedDirections = (@get("playedDirections") or [])[0..-2]
  #     playedCount = playedDirections.filter((direction) => direction == @get("direction")).length
  #     n = 13 - playedCount
  #     "" for i in [1..n]
  # ).property("initial.@each", "played.@each", "playedDirections.@each", "trump")

  # play: (card) ->
  #   @get("controllers.board.cards").pushObject(card)

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
