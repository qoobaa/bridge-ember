@Bridge.BiddingBoxController = Ember.Controller.extend
  needs: ["board"]

  contractBinding: "controllers.board.incompletedContract"
  currentDirectionBinding: "controllers.board.currentAuctionDirection"
  isCompletedBinding: "controllers.board.isAuctionCompleted"

  contractDirection: (-> @get("contract")?[-1..-1]).property("contract")
  contractDirectionIndex: (-> Bridge.DIRECTIONS.indexOf(@get("contractDirection"))).property("contractDirection")
  contractSide: (-> Bridge.SIDES[@get("contractDirectionIndex") % 2]).property("contractDirectionIndex")
  contractLevel: (-> parseInt(contract[0], 10) if contract = @get("contract")).property("contract")
  contractSuit: (-> /C|D|H|S|NT/.exec(@get("contract")?[0])).property("contract")
  bareContract: (-> /[1-7](?:C|D|H|S|NT)/.exec(@get("contract"))?[0]).property("contract")
  isDoubled: (-> /X/.test(@get("contract"))).property("contract")
  isRedoubled: (-> /XX/.test(@get("contract"))).property("contract")
  currentDirectionIndex: (-> Bridge.DIRECTIONS.indexOf(@get("currentDirection"))).property("currentDirection")
  currentSide: (-> Bridge.SIDES[@get("currentDirectionIndex") % 2]).property("currentDirectionIndex")

  bid: (bid) ->
    @set("level", null)
    @get("controllers.board.bids").pushObject(bid)

  bidLevel: (level) -> @set("level", level)
