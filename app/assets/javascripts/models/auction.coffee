@Bridge.Auction = Ember.ArrayProxy.extend
  content: (-> @get("bids")?.map(Bridge.Bid.wrap)).property("bids.@each")
  contract: (-> @filterProperty("isContract").get("lastObject")).property("@each")
  contractSideBinding: "contract.side"
  contractTrumpBinding: "contract.trump"
  currentBids: (-> if contract = @get("contract") then @slice(@indexOf(contract)) else []).property("contract", "@each")
  modifier: (-> @get("currentBids").filterProperty("isModifier").get("lastObject")).property("currentBids", "@each.isModifier")
  double: (-> @get("currentBids").filterProperty("isDouble").get("lastObject")).property("currentBids", "@each.isDouble")
  redouble: (-> @get("currentBids").filterProperty("isRedouble").get("lastObject")).property("currentBids", "@each.isRedouble")
  isCompleted: (-> @get("length") > 3 and @slice(@get("length") - 3).everyProperty("isPass")).property("length", "@each.isPass")
  declarer: (->
    @filterProperty("side", @get("contractSide")).filterProperty("trump", @get("contractTrump")).get("firstObject.direction")
  ).property("contractSide", "contractTrump", "@each.direction")
  currentDirection: (-> @get("lastObject.direction.next") or @get("dealer")).property("lastObject.direction.next", "dealer")

  contentDidChange: (->
    currentDirection = @get("dealer")
    @forEach (bid) =>
      bid.set("direction", currentDirection)
      currentDirection = currentDirection.get("next")
  ).observes("@each", "dealer")
