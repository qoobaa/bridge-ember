@Bridge.Board = Ember.Object.extend
  playContractObserver: (->
    @get("play").set("contract", @get("auction.contract")) if @get("auction.isCompleted") and @get("auction.contract")
  ).observes("auction.isCompleted")

  auction: ((key, value) ->
    if arguments.length == 2
      if value instanceof Bridge.Auction
        value
      else
        Bridge.Auction.create(content: value)
  ).property()

  play: ((key, value) ->
    if arguments.length == 2
      if value instanceof Bridge.Play
        value
      else
        Bridge.Play.create(content: value)
  ).property()
