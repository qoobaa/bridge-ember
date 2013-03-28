@Bridge.HandController = Ember.ArrayController.extend
  init: ->
    @_super.apply(@, arguments)
    @initialDidChange()

  playDidChange: (->
    @get("play")?.addArrayObserver(@, willChange: @playContentWillChange, didChange: @playContentDidChange)
  ).observes("play")

  playWillChange: (->
    @get("play")?.removeArrayObserver(@)
  ).observesBefore("play")

  # unlikely to happen, but when it does, we just add a card to the end of hand
  playContentWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        card = content.objectAt(i)
        @pushObject(card.get("content")) if card.get("direction") == @get("direction")

  playContentDidChange: (content, index, removedCount, addedCount) ->
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
    console.log(@toArray())
    @some((card) => card?[0] == @get("currentSuit"))
  ).property("content.@each", "currentSuit")

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
