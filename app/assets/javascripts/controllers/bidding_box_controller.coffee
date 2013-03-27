@Bridge.BiddingBoxController = Ember.Controller.extend
  needs: ["board"]

  init: ->
    @_super.apply(@, arguments)
    @set("auction", Bridge.Auction.create({dealer: "N", content: []}))

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
    @get("auction").pushObject(bid)
