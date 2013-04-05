@Bridge.Board = Ember.Object.extend
  contract: (->
    @get("auction.contract") if @get("auction.isCompleted")
  ).property("auction.contract", "auction.isCompleted")

  currentDirection: (->
    if @get("auction.isCompleted") then @get("play.currentDirection") else @get("auction.currentDirection")
  ).property("auction.isCompleted", "auction.currentDirection", "play.currentDirection")

  init: ->
    @_super.apply(@, arguments)
    @set("auction", Bridge.Auction.create(board: @, contentBinding: "board.bids", dealerBinding: "board.dealer"))
    @set("play", Bridge.Play.create(board: @, contentBinding: "board.cards", contractBinding: "board.contract"))
