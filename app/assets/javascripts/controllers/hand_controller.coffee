@Bridge.HandController = Ember.ArrayController.extend
  playDidChange: (->
    @get("play")?.addArrayObserver(@, willChange: @playContentWillChange, didChange: @playContentDidChange)
  ).observes("play")

  playWillChange: (->
    @get("play")?.removeArrayObserver(@)
  ).observesBefore("play")

  initialDidChange: (->
    cards = Bridge.Utils.sortCards(@get("initial") || ["", "", "", "", "", "", "", "", "", "", "", "", ""], @get("trump"))
    @set("content", cards.map (card) -> Bridge.Card.create(content: card))
  ).observes("initial", "trump")

  # unlikely to happen, but when it does, we just add a card to the end of hand
  playContentWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        card = content.objectAt(i)
        @pushObject(card) if card.get("direction") == @get("direction")

  playContentDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        card = content.objectAt(i)
        if card.get("direction") == @get("direction")
          if @contains(card) then @removeObject(card) else @popObject()

  currentSuitBinding: "play.currentSuit"
  currentDirectionBinding: "play.currentDirection"
  trumpBinding: "play.contract.trump"

  hasCardInCurrentSuit: (->
    @some((card) => card.suit == @get("currentSuit"))
  ).property("@each", "currentSuit")

  playCard: (card) ->
    @get("play").pushObject(card)

Bridge.register "controller:hand_n", Bridge.HandController.extend
  direction: "N"

Bridge.register "controller:hand_e", Bridge.HandController.extend
  direction: "E"

Bridge.register "controller:hand_s", Bridge.HandController.extend
  direction: "S"

Bridge.register "controller:hand_w", Bridge.HandController.extend
  direction: "W"
