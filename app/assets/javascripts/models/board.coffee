@Bridge.Board = Ember.Object.extend
  dealer: "N"
  bids: []
  cards: []

  declarerBinding: "auction.declarer"
  contractBinding: "auction.contract"

  init: ->
    @_super.apply(@, arguments)

    @set "auction", Bridge.Auction.create
      board: @
      dealerBinding: "board.dealer"
      content: []

    @set "play", Bridge.Play.create
      board: @
      declarerBinding: "board.declarer"
      trumpBinding: "board.contract.trump"
      content: []

    @bidsDidChange()
    @cardsDidChange()

  bidsDidChange: (->
    @set("auction.content", @get("bids").map (bid) -> Bridge.Bid.create(bid: bid))
  ).observes("bids.@each")

  cardsDidChange: (->
    @set("play.content", @get("cards").map (card) -> Bridge.Card.create(card: card))
  ).observes("cards.@each")
