@Bridge.Auction = Ember.ArrayProxy.extend
  arrangedContent: (->
    @get("content")?.map (bid, i) -> Bridge.Bid.create(content: bid)
  ).property()

  contentArrayWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        @get("arrangedContent").removeAt(i)

  contentArrayDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        @get("arrangedContent").insertAt(i, Bridge.Bid.create(content: content.objectAt(i)))

  reindex: (->
    Bridge.Utils.auctionDirections(@get("dealer"), @get("content")).forEach (direction, i) =>
      @get("arrangedContent.#{i}").setProperties(index: i, direction: direction)
  ).observes("dealer", "arrangedContent.@each")

  init: ->
    @_super.apply(@, arguments)
    @reindex()

  isCompleted: (->
    @get("length") > 3 and @slice(@get("length") - 3).everyProperty("isPass")
  ).property("length", "@each.isPass")

  currentDirection: (->
    Bridge.Utils.auctionDirections(@get("dealer"), @get("content").concat("")).get("lastObject")
  ).property("dealer", "content")

  contract: (->
    if @get("isCompleted")
      Bridge.Utils.auctionContract(@get("dealer"), @get("content"))
  ).property("isCompleted", "content.@each")
