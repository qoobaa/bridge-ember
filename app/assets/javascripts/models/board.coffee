@Bridge.Board = Ember.Object.extend
  contract: (->
    @get("auction.contract") if @get("auction.isCompleted")
  ).property("auction.contract", "auction.isCompleted")

  init: ->
    @_super.apply(@, arguments)
    @set("auction", Bridge.Auction.create(board: @, contentBinding: "board.bids", dealerBinding: "board.dealer"))
    @set("play", Bridge.Play.create(board: @, contentBinding: "board.cards", contractBinding: "board.contract"))
