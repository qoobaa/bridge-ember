@Bridge.Board = Ember.Object.extend
  state: Ember.Object.create
    dealer: "N"
    bids: []
    cards: []

  dealer: (-> Bridge.Direction.create(direction: @get("state.dealer"))).property("state.dealer")
  declarerBinding: "auction.declarer"
  contractBinding: "auction.contract"

  init: ->
    @_super.apply(@, arguments)

    @set "auction", Bridge.Auction.create
      board: @
      dealerBinding: "board.dealer"

    @set "play", Bridge.Play.create
      board: @
      declarerBinding: "board.declarer"
      trumpBinding: "board.contract.trump"

    @bidsDidChange()
    @cardsDidChange()

  bidsDidChange: (->
    @set("auction.content", @get("state.bids").map (bid) -> Bridge.Bid.create(bid: bid))
  ).observes("state.bids.@each")

  cardsDidChange: (->
    @set("play.content", @get("state.cards").map (card) -> Bridge.Card.create(card: card))
  ).observes("state.cards.@each")
