@Bridge.Board = Ember.Object.extend
  state: Ember.Object.create
    dealer: "N"
    bids: []
    cards: []
    n: []
    e: []
    s: []
    w: []

  contractBinding: "auction.contract"

  phase: (->
    if @get("play.isCompleted")
      "completed"
    else if @get("auction.isCompleted")
      "play"
    else
      "auction"
  ).property("auction.isCompleted", "play.isCompleted")

  direction: (->
    @get("#{@get('phase')}.currentDirection")
  ).property("phase", "auction.currentDirection", "play.currentDirection")

  init: ->
    @_super.apply(@, arguments)

    @set "auction", Bridge.Auction.create
      board: @
      contentBinding: "board.state.content"
      dealerBinding: "board.state.dealer"

    @set "play", Bridge.Play.create
      board: @
      contentBinding: "board.state.content"
      contractBinding: "board.contract"
