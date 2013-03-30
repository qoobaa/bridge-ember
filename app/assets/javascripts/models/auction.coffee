@Bridge.Auction = Ember.ArrayProxy.extend
  init: ->
    @_super.apply(@, arguments)
    @reindex()

  reindex: (->
    Bridge.Utils.auctionDirections(@get("dealer"), @get("content").mapProperty("content").concat("")).forEach (direction, i) =>
      if bid = @get("content.#{i}")
        bid.setProperties(index: i, direction: direction)
      else
        @set("currentDirection", direction)
  ).observes("dealer", "content.@each")

  isCompleted: (->
    @get("length") > 3 and @slice(@get("length") - 3).everyProperty("isPass")
  ).property("length", "@each.isPass")

  currentSide: (->
    if /N|S/.test(@get("currentDirection")) then "NS" else "EW"
  ).property("currentDirection")

  contract: (->
    contract = Bridge.Utils.auctionContract(@get("dealer"), @get("content").mapProperty("content"))
    Bridge.Contract.create(content: contract) if contract?
  ).property("isCompleted", "content.@each")
