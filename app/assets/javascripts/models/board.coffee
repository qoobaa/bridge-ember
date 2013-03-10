@Bridge.Board = Ember.Object.extend
  state: Ember.Object.create
    dealer: "N"
    bids: []
    cards: []
    n: []
    e: []
    s: []
    w: []

  bids: (-> @get("state.bids").map (bid) -> Bridge.Bid.create(bid: bid)).property("state.bids.@each")
  cards: (-> @get("state.cards").map (card) -> Bridge.Card.create(card: card)).property("state.cards.@each")
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
      contentBinding: "board.bids"
      dealerBinding: "board.dealer"

    @set "play", Bridge.Play.create
      board: @
      contentBinding: "board.cards"
      declarerBinding: "board.declarer"
      trumpBinding: "board.contract.trump"
