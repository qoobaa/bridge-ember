@Bridge.DirectionController = Ember.Controller.extend
  needs: ["table"]

  auctionBinding: "controllers.table.content.board.auction"
  playBinding: "controllers.table.content.board.play"

  current: (->
    if @get("auction.isCompleted") then @get("play.currentDirection") else @get("auction.currentDirection")
  ).property("auction.isCompleted", "auction.currentDirection", "play.currentDirection")
