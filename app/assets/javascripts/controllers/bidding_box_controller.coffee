@Bridge.BiddingBoxController = Ember.ArrayController.extend
  content: []

  bidContract: (contract) ->
    @pushObject(Bridge.Bid.create(value: contract))

  bidPass: ->
    @pushObject(Bridge.Bid.create(value: "PASS"))

  bidDouble: ->
    @pushObject(Bridge.Bid.create(value: "X"))

  bidRedouble: ->
    @pushObject(Bridge.Bid.create(value: "XX"))
