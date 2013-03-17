@Bridge.BiddingBoxController = Ember.Controller.extend
  needs: ["board"]

  contractBinding: "controllers.board.incompletedContract"
  contractDirection: (-> contract[-1..-1] if contract = @get("contract")).property("contract")
  contractDirectionIndex: (-> Bridge.DIRECTIONS.indexOf(@get("currentDirection"))).property("contractDirection")
  contractSide: (-> Bridge.SIDES[@get("contractDirectionIndex") % 2]).property("contractDirectionIndex")
  level: (-> parseInt(contract[0], 10) if contract = @get("contract")).property("")
  isDoubled: (-> /X/.test(@get("contract"))).property("contract")
  isRedoubled: (-> /XX/.test(@get("contract"))).property("contract")
  currentDirectionBinding: "controllers.board.currentAuctionDirection"
  currentDirectionIndex: (-> Bridge.DIRECTIONS.indexOf(@get("currentDirection"))).property("currentDirection")
  currentSide: (-> Bridge.SIDES[@get("currentDirectionIndex") % 2]).property("currentDirectionIndex")

  bid: (bid) ->
    @set("level", null)
    @get("controllers.board.state.bids").pushObject(bid.get("bid"))

  bidLevel: (level) -> @set("level", level)
