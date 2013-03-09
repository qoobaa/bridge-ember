@Bridge.Auction = Ember.ArrayProxy.extend
  contract: (-> @filterProperty("isContract").get("lastObject")).property("@each")
  contractSideBinding: "contract.side"
  contractTrumpBinding: "contract.trump"
  currentBids: (-> if contract = @get("contract") then @slice(@indexOf(contract)) else []).property("contract", "@each")
  modifier: (-> @get("currentBids").filterProperty("isModifier").get("lastObject")).property("currentBids")
  double: (-> @get("currentBids").filterProperty("isDouble").get("lastObject")).property("currentBids")
  redouble: (-> @get("currentBids").filterProperty("isRedouble").get("lastObject")).property("currentBids")
  isCompleted: (-> @get("length") > 3 and @slice(@get("length") - 3).everyProperty("isPass")).property("@each")
  declarer: (->
    @filterProperty("side", @get("contractSide")).filterProperty("trump", @get("contractTrump")).get("firstObject.direction")
  ).property("contractSide", "contractTrump")
  currentDirectionBinding: "lastObject.direction.next"

  contentDidChange: (->
    currentDirection = @get("dealer")
    @forEach (bid) =>
      bid.set("direction", currentDirection)
      currentDirection = currentDirection.get("next")
  ).observes("@each", "dealer")
