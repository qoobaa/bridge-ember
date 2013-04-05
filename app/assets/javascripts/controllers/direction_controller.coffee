@Bridge.DirectionController = Ember.Controller.extend
  needs: ["table"]

  auctionBinding: "controllers.table.board.auction"
  playBinding: "controllers.table.board.play"

  current: (->
    if @get("auction.isCompleted") then @get("play.currentDirection") else @get("auction.currentDirection")
  ).property("auction.isCompleted", "auction.currentDirection", "play.currentDirection")
