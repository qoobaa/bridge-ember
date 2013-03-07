@Bridge.AuctionController = Ember.ArrayController.extend
  content: []
  dealer: "S"

  dealerIndex: (-> Bridge.DIRECTIONS.indexOf(@get("dealer"))).property("dealer")
  contract: (-> @filterProperty("isContract").get("lastObject")).property("@each", "@each.value")
  currentBids: (-> if contract = @get("contract") then @slice(@indexOf(contract)) else []).property("contract", "@each", "@each.value")
  modifier: (-> @get("currentBids").filterProperty("isModifier").get("lastObject")).property("currentBids")
  double: (-> @get("currentBids").filterProperty("isDouble").get("lastObject")).property("currentBids")
  redouble: (-> @get("currentBids").filterProperty("isRedouble").get("lastObject")).property("currentBids")
  isCompleted: (-> @get("length") > 3 and @slice(@get("length") - 3).everyProperty("isPass")).property("@each", "@each.value")
  currentDirection: (-> Bridge.DIRECTIONS[(@get("length") + @get("dealerIndex")) % 4]).property("length", "dealerIndex")
  currentSide: (-> Bridge.SIDES[@get("currentDirection")]).property("currentDirection")
  declarer: (->
    if contract = @get("contract")
      @filterProperty("side", contract.get("side")).filterProperty("trump", contract.get("trump")).get("firstObject.direction")
  ).property("contract")

  contentDidChange: (->
    @forEach (bid, i) => bid.set("direction", Bridge.DIRECTIONS[(@get("dealerIndex") + i) % 4])
  ).observes("@each", "dealerIndex")
