@Bridge.BiddingBoxController = Ember.Controller.extend
  needs: ["table"]

  auctionBinding: "controllers.table.board.auction"

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

  loggedInUserIdBinding: "Bridge.env.userId"
  currentUserIdBinding: "controllers.table.currentUser.id"

  isActive: (->
    @get("currentUserId") == @get("loggedInUserId")
  ).property("loggedInUserId", "currentUserId")

  bid: (bid) ->
    @set("level", null)
    @get("auction.content").pushObject(bid)
