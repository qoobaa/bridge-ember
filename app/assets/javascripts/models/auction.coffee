@Bridge.Auction = Ember.ArrayProxy.extend
  objectAtContent: (index) ->
    Bridge.Bid.create
      content: @get("content").objectAt(index)
      index: index
      auction: @
      dealerBinding: "auction.dealer"

  lastContract: (->
    @filterProperty("isContract").get("lastObject")
  ).property("@each.isContract", "lastObject")

  lastContractModifier: (->
    @slice(@indexOf(lastContract)).filterProperty("isModifier").get("lastObject") if lastContract = @get("lastContract")
  ).property("lastContract", "@each")

  lastContractContentBinding: "lastContract.content"
  lastContractModifierContentBinding: "lastContractModifier.content"
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
      [@get("lastContractContent"), @get("lastContractModifierContent"), @get("lastContractSuitFirstDeclarer")].without(undefined).join("")
  ).property("lastContractContent", "lastContractModifierContent", "lastContractSuitFirstDeclarer", "isCompleted")
