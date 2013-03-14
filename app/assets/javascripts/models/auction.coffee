@Bridge.Auction = Ember.ArrayProxy.extend
  objectAtContent: (index) ->
    if bid = @get("content").objectAt(index)
      Bridge.Bid.create(content: bid, index: index)

  lastContract: (->
    @filterProperty("isContract").get("lastObject")
  ).property("@each.isContract")

  lastContractIndexBinding: "lastContract.index"

  lastContractModifier: (->
    if lastContractIndex = @get("lastContractIndex")
      @slice(lastContractIndex).filterProperty("isModifier").get("lastObject")
  ).property("lastContract", "@each")

  lastContractBidBinding: "lastContract.bid"
  lastContractModifierBidBinding: "lastContractModifier.bid"
  lastContractSideBinding: "lastContract.side"
  lastContractTrumpBinding: "lastContract.trump"

  lastContractSuitFirstDeclarer: (->
    @filterProperty("side", @get("lastContractSide")).filterProperty("trump", @get("lastContractTrump")).get("firstObject.direction")
  ).property("lastContractSide", "lastContractTrump", "@each.direction")

  isCompleted: (->
    @get("length") > 3 and @slice(@get("length") - 3).everyProperty("isPass")
  ).property("length", "@each.isPass")

  lastDirectionBinding: "lastObject.direction"

  lastDirectionIndex: (->
    Bridge.DIRECTIONS.indexOf(@get("lastDirection")) if @get("lastDirection")
  ).property("lastDirection")

  currentDirection: (->
    if @get("lastDirectionIndex")
      Bridge.DIRECTIONS[(@get("lastDirectionIndex") + 1) % 4]
    else
      @get("dealer")
  ).property("lastDirectionIndex", "dealer")

  contract: (->
    if @get("isCompleted")
      [@get("lastContractBid"),
       @get("lastContractModifierBid"),
       @get("lastContractSuitFirstDeclarer")].without(undefined).join("") or undefined
  ).property("lastContractBid", "lastContractModifierBid", "lastContractSuitFirstDeclarer", "isCompleted")
