@Bridge.Bid = Ember.Object.extend
  isContract: (-> @get("bid") in Bridge.CONTRACTS).property("bid")
  isDouble: (-> @get("bid") == Bridge.DOUBLE).property("bid")
  isRedouble: (-> @get("bid") == Bridge.REDOUBLE).property("bid")
  isModifier: (-> @get("bid") in Bridge.MODIFIERS).property("bid")
  isPass: (-> @get("bid") == Bridge.PASS).property("bid")
  level: (-> parseInt(@get("bid")[0], 10) if @get("isContract")).property("bid", "isContract")
  trump: (-> @get("bid")[1..2] if @get("isContract")).property("bid", "isContract")
  order: (-> Bridge.CONTRACTS.indexOf(@get("bid")) if @get("isContract")).property("bid", "isContract")

  contractBinding: "auction.contract"
  doubleBinding: "auction.double"
  redoubleBinding: "auction.redouble"
  currentSideBinding: "auction.currentDirection.side"
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
