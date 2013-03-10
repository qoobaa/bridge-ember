@Bridge.Board = Ember.Object.extend
  state: Ember.Object.create
    dealer: "N"
    bids: []
    cards: []
    n: []
    e: []
    s: []
    w: []

  dealer: (-> Bridge.Direction.create(direction: @get("state.dealer"))).property("state.dealer")
  declarerBinding: "auction.declarer"
  contractBinding: "auction.contract"
  phase: (->
    if @get("play.isCompleted")
      "completed"
    else if @get("auction.isCompleted")
      "play"
    else
      "auction"
  ).property("auction.isCompleted", "play.isCompleted")
  direction: (-> @get("#{@get('phase')}.currentDirection")).property("phase", "auction.currentDirection", "play.currentDirection")

  init: ->
    @_super.apply(@, arguments)

    @set "auction", Bridge.Auction.create
      board: @
      bidsBinding: "board.state.bids"
      dealerBinding: "board.dealer"

    @set "play", Bridge.Play.create
      board: @
      cardsBinding: "board.state.cards"
      declarerBinding: "board.declarer"
      trumpBinding: "board.contract.trump"
