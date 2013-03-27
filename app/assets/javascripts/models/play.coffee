@Bridge.Play = Ember.ArrayProxy.extend
  contract: ((key, value) ->
    Bridge.Contract.create(content: value) unless value instanceof Bridge.Contract
  ).property()

  trumpBinding: "contract.trump"
  declarerBinding: "contract.direction"

  init: ->
    @_super.apply(@, arguments)
    @reindex()

  arrangedContent: (->
    @get("content").map (card, i) -> Bridge.Card.create(content: card)
  ).property()

  contentArrayWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        @get("arrangedContent").removeAt(i)

  contentArrayDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        @get("arrangedContent").insertAt(i, Bridge.Card.create(content: content.objectAt(i)))

  reindex: (->
    Bridge.Utils.playDirections(@get("declarer"), @get("trump"), @get("content").concat("")).forEach (direction, i) =>
      if card = @get("arrangedContent.#{i}")
        card.setProperties(index: i, direction: direction)
      else
        @set("currentDirection", direction)
  ).observes("declarer", "arrangedContent.@each")

  isCompleted: (->
    @get("length") == 52
  ).property("length")

  currentDirection: (->
    Bridge.Utils.playDirections(@get("declarer"), @get("trump"), @get("content").concat("")).get("lastObject")
  ).property()
