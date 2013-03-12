@Bridge.Play = Ember.ArrayProxy.extend
  arrangedContent: (->
    @get("content")?.map (card, i) -> Bridge.Card.create(content: card)
  ).property()

  contentArrayWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        @get("arrangedContent").removeAt(i)

  contentArrayDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        @get("arrangedContent").insertAt(i, Bridge.Card.create(content: content.objectAt(i)))

  declarer: (->
    @get("contract")[-1..-1]
  ).property("contract")

  trump: (->
    suit = @get("contract")[1..1]
    if suit == "N" then undefined else suit
  ).property("contract")

  isCompleted: (->
    @get("length") == 52
  ).property("length")

  currentTrickNumber: (->
    Math.floor(@get("length") / 4)
  ).property("length")

  currentDirection: (->
    Bridge.Utils.playDirections(@get("declarer"), @get("trump"), @get("content").concat("")).get("lastObject")
  ).property("declarer", "trump", "content.@each")

  currentSuit: (->
    @get("arrangedContent.#{@get('currentTrickNumber') * 4}.suit")
  ).property("currentTrickNumber", "arrangedContent.@each")

  reindex: (->
    Bridge.Utils.playDirections(@get("declarer"), @get("trump"), @get("content")).map (direction, i) =>
      @get("arrangedContent.#{i}").setProperties(direction: direction, index: i)
  ).observes("declarer", "trump", "arrangedContent.@each")

  init: ->
    @_super.apply(@, arguments)
    @reindex()
