@Bridge.TrickController = Ember.ArrayController.extend
  playDidChange: (->
    @get("play")?.addArrayObserver(@, willChange: @playContentWillChange, didChange: @playContentDidChange)
  ).observes("play")

  playWillChange: (->
    @get("play")?.removeArrayObserver(@)
  ).observesBefore("play")

  playContentWillChange: (content, index, removedCount, addedCount) ->
    # if removedCount
    #   for i in [index..(index + removedCount - 1)]
    #     card = content.objectAt(i)
    #     @pushObject(card.get("content")) if card.get("direction") == @get("direction")

  playContentDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        card = content.objectAt(i)
        if card.get("trick") != content.objectAt(i - 1)?.get("trick")
          @set("content", [card.get("content")])
        else
          @get("content").pushObject(card.get("content"))
