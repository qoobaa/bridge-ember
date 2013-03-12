@Bridge.Bid = Ember.Object.extend
  isContract: (-> @get("content") in Bridge.CONTRACTS).property("content")
  isDouble: (-> @get("content") == Bridge.DOUBLE).property("content")
  isRedouble: (-> @get("content") == Bridge.REDOUBLE).property("content")
  isModifier: (-> @get("content") in Bridge.MODIFIERS).property("content")
  isPass: (-> @get("content") == Bridge.PASS).property("content")
  level: (-> parseInt(@get("content")[0], 10) if @get("isContract")).property("content", "isContract")
  trump: (-> @get("content")[1..2] if @get("isContract")).property("content", "isContract")
  order: (-> Bridge.CONTRACTS.indexOf(@get("content")) if @get("isContract")).property("content", "isContract")
  directionIndex: (-> Bridge.DIRECTIONS.indexOf(@get("direction"))).property("direction")
  side: (-> Bridge.SIDES[@get("directionIndex") % 2]).property("directionIndex")

#   contractBinding: "auction.contract"
#   doubleBinding: "auction.double"
#   redoubleBinding: "auction.redouble"
#   currentSideBinding: "auction.lastObject.direction.next.side"
#   contractSideBinding: "auction.contract.direction.side"
#   contractOrderBinding: "auction.contract.order"

#   isEnabled: (->
#     switch @get("content")
#       when "PASS"
#         true
#       when "X"
#         @get("contract")? and not @get("double")? and @get("currentSide") != @get("contractSide")
#       when "XX"
#         @get("contract")? and @get("double")? and not @get("redouble") and @get("currentSide") == @get("contractSide")
#       else
#         contractOrder = @get("contractOrder")
#         contractOrder = -1 unless contractOrder?
#         @get("order") > contractOrder
#   ).property("content", "contract", "double", "currentSide", "contractSide", "redouble", "contractOrder")
#   isDisabled: (-> not @get("isEnabled")).property("isEnabled")
