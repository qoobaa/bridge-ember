@Bridge.HandController = Ember.ArrayController.extend
  init: ->
    window.A = @
    @_super.apply(@, arguments)
    @set("play", Bridge.Play.create(content: [], contract: "4NT"))
    @get("play").addArrayObserver(@, willChange: @playWillChange, didChange: @playDidChange)
    @initialDidChange()

  # unlikely to happen, but when it does, we just add a card to the end of hand
  playWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        card = content.objectAt(i)
        @pushObject(card.get("content")) if card.get("direction") == @get("direction")

  playDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        card = content.objectAt(i)
        cardContent = card.get("content")
        if card.get("direction") == @get("direction")
          if @contains(cardContent) then @removeObject(cardContent) else @popObject()

  currentSuitBinding: "play.currentSuit"
  currentDirectionBinding: "play.currentDirection"
  trumpBinding: "play.contract.trump"

  initialDidChange: (->
    @set("content", Bridge.Utils.sortCards(@get("initial") || ["", "", "", "", "", "", "", "", "", "", "", "", ""], @get("trump")))
  ).observes("initial", "trump")

  hasCardInCurrentSuit: (->
    @some((card) => card[0] == @get("currentSuit"))
  ).property("content.@each", "currentSuit")

  play: (card) ->
    @get("play").pushObject(card)

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
