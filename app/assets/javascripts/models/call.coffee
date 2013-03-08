@Bridge.Call = Ember.ObjectProxy.extend
  bid: null
  biddingBox: null
  auctionBinding: null
  auction: null

  contract: null
  double: null
  redouble: null
  currentSide: null
  contractSide: null
  contractOrder: null

  contractBinding: "auction.contract"
  doubleBinding: "auction.double"
  redoubleBinding: "auction.redouble"
  currentSideBinding: "auction.lastObject.direction.next.side"
  contractSideBinding: "auction.contract.direction.side"
  contractOrderBinding: "auction.contract.order"

  isEnabled: (->
    switch @get("bid")
      when "PASS"
        true
      when "X"
        @get("contract")? and not @get("double")? and @get("currentSide") != @get("contractSide")
      when "XX"
        @get("contract")? and @get("double")? and not @get("redouble") and @get("currentSide") == @get("contractSide")
      else
        contractOrder = @get("contractOrder")
        contractOrder = -1 unless contractOrder?
        @get("order") > contractOrder
  ).property("bid", "contract", "double", "currentSide", "contractSide", "redouble", "contractOrder")
  isDisabled: (-> not @get("isEnabled")).property("isEnabled")

  init: ->
    @_super.apply(@, arguments)
    @set("content", Bridge.Bid.create(call: @, bidBinding: "call.bid"))
