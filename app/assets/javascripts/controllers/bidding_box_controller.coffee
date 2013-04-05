@Bridge.BiddingBoxController = Ember.Controller.extend
  needs: ["table"]

  auctionBinding: "controllers.table.content.board.auction"

  contractBinding: "auction.contract"
  contractDirectionBinding: "contract.direction"
  contractSideBinding: "contract.side"
  contractLevelBinding: "contract.level"
  contractTrumpBinding: "contract.trump"
  contractBidBinding: "contract.bid"
  isContractDoubledBinding: "contract.isDoubled"
  isContractRedoubledBinding: "contract.isRedoubled"

  currentDirectionBinding: "auction.currentDirection"
  currentSideBinding: "auction.currentSide"
  isCompletedBinding: "auction.isCompleted"

  bid: (bid) ->
    @set("level", null)
    @get("auction.content").pushObject(bid)
