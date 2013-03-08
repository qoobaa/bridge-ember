@Bridge.BiddingBoxController = Ember.Controller.extend
  needs: ["board"]
  auctionBinding: "controllers.board.auction"

  init: ->
    @_super.apply(@, arguments)
    @set("levels", Bridge.Call.create(bid: "#{i}NT", biddingBox: @, auctionBinding: "biddingBox.auction") for i in [1..7])
    @set("pass", Bridge.Call.create(bid: "PASS", biddingBox: @, auctionBinding: "biddingBox.auction"))
    @set("double", Bridge.Call.create(bid: "X", biddingBox: @, auctionBinding: "biddingBox.auction"))
    @set("redouble", Bridge.Call.create(bid: "XX", biddingBox: @, auctionBinding: "biddingBox.auction"))

  trumps: (->
    if level = @get("level")
      Bridge.Call.create(bid: "#{level}#{i}", biddingBox: @, auctionBinding: "biddingBox.auction") for i in ["C", "D", "H", "S", "NT"]
    else
      []
  ).property("level")

  bid: (bid) ->
    @set("level", null)
    @get("controllers.board.state.bids").pushObject(bid.get("bid"))

  bidLevel: (level) -> @set("level", level)
