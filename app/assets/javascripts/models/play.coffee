@Bridge.Play = Ember.ArrayProxy.extend
  contract: ((key, value) ->
    if arguments.length == 2
      if value instanceof Bridge.Contract
        value
      else
        Bridge.Contract.create(content: value)
  ).property()

  trumpBinding: "contract.trump"
  declarerBinding: "contract.direction"

  init: ->
    @_super.apply(@, arguments)
    @reindex()

  arrangedContent: (->
    # FIXME: remove Ember.copy
    # @get("content").map (card, i) -> Bridge.Card.create(content: card)
    Ember.copy @get("content")
  ).property()

  contentArrayWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        @get("arrangedContent").removeAt(i)

  contentArrayDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        @get("arrangedContent").insertAt(i, content.objectAt(i))

  reindex: (->
    Bridge.Utils.playDirections(@get("declarer"), @get("trump"), @get("content").concat("")).forEach (direction, i, directions) =>
      if card = @get("arrangedContent.#{i}")
        card.setProperties(index: i, direction: direction, isWinning: direction == directions[i + 1])
      else
        @set("currentDirection", direction)
  ).observes("declarer", "trump", "arrangedContent.@each")

  isCompleted: (->
    @get("length") == 52
  ).property("length")

  currentSuit: (->
    @filterProperty("isLead").get("lastObject.suit") if @get("length") % 4 != 0
  ).property("length", "arrangedContent.@each")
