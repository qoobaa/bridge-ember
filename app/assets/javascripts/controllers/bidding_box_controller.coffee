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

  loggedInUserIdBinding: "Bridge.session.userId"
  currentUserIdBinding: "controllers.table.currentUser.id"

  isEnabled: (->
    !@get("isCompleted") and @get("currentUserId") == @get("loggedInUserId")
  ).property("loggedInUserId", "currentUserId", "isCompleted")

  bid: (bid) ->
    @set("level", null)
    Bridge.Bid.create(content: bid).save(@get("controllers.table.board.id"))
