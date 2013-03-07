@Bridge.BiddingBoxController = Ember.Controller.extend
  needs: ["auction"]

  contractBinding: "controllers.auction.contract"
  doubleBinding: "controllers.auction.double"
  redoubleBinding: "controllers.auction.redouble"

  level: null

  is1Disabled: (-> @isLevelDisabled(1) ).property("contract")
  is2Disabled: (-> @isLevelDisabled(2) ).property("contract")
  is3Disabled: (-> @isLevelDisabled(3) ).property("contract")
  is4Disabled: (-> @isLevelDisabled(4) ).property("contract")
  is5Disabled: (-> @isLevelDisabled(5) ).property("contract")
  is6Disabled: (-> @isLevelDisabled(6) ).property("contract")
  is7Disabled: (-> @isLevelDisabled(7) ).property("contract")

  isCDisabled: (-> @isTrumpDisabled("C") ).property("contract", "level")
  isDDisabled: (-> @isTrumpDisabled("D") ).property("contract", "level")
  isHDisabled: (-> @isTrumpDisabled("H") ).property("contract", "level")
  isSDisabled: (-> @isTrumpDisabled("S") ).property("contract", "level")
  isNTDisabled: (-> @isTrumpDisabled("NT") ).property("contract", "level")

  isLevelDisabled: (level) ->
    @get("contract.level") > level or @get("contract.level") == level and @get("contract.trump") == "NT"

  isTrumpDisabled: (trump) ->
    not @get("level")? or @get("level") == @get("contract.level") and Bridge.TRUMPS.indexOf(trump) <= Bridge.TRUMPS.indexOf(@get("contract.trump"))

  bidContract: (contract) ->
    @set("level", null)
    @get("controllers.auction").pushObject(Bridge.Bid.create(value: contract))

  bidPass: ->
    @get("controllers.auction").pushObject(Bridge.Bid.create(value: "PASS"))

  bidDouble: ->
    @get("controllers.auction").pushObject(Bridge.Bid.create(value: "X"))

  bidRedouble: ->
    @get("controllers.auction").pushObject(Bridge.Bid.create(value: "XX"))

  bid1: -> @set("level", 1)
  bid2: -> @set("level", 2)
  bid3: -> @set("level", 3)
  bid4: -> @set("level", 4)
  bid5: -> @set("level", 5)
  bid6: -> @set("level", 6)
  bid7: -> @set("level", 7)

  bidC: -> @bidContract(@get("level") + "C")
  bidD: -> @bidContract(@get("level") + "D")
  bidH: -> @bidContract(@get("level") + "H")
  bidS: -> @bidContract(@get("level") + "S")
  bidNT: -> @bidContract(@get("level") + "NT")
