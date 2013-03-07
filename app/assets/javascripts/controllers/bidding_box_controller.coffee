@Bridge.BiddingBoxController = Ember.Controller.extend
  needs: ["auction"]

  contractBinding: "controllers.auction.contract"
  doubleBinding: "controllers.auction.double"
  redoubleBinding: "controllers.auction.redouble"
  currentDirectionBinding: "controllers.auction.currentDirection"
  currentSideBinding: "controllers.auction.currentSide"
  isCompletedBinding: "controllers.auction.isCompleted"

  level: null

  is1Disabled: (-> not @isLevelEnabled(1)).property("isEnabled", "contract")
  is2Disabled: (-> not @isLevelEnabled(2)).property("isEnabled", "contract")
  is3Disabled: (-> not @isLevelEnabled(3)).property("isEnabled", "contract")
  is4Disabled: (-> not @isLevelEnabled(4)).property("isEnabled", "contract")
  is5Disabled: (-> not @isLevelEnabled(5)).property("isEnabled", "contract")
  is6Disabled: (-> not @isLevelEnabled(6)).property("isEnabled", "contract")
  is7Disabled: (-> not @isLevelEnabled(7)).property("isEnabled", "contract")

  isCDisabled: (-> not @isTrumpEnabled("C")).property("isEnabled", "contract", "level")
  isDDisabled: (-> not @isTrumpEnabled("D")).property("isEnabled", "contract", "level")
  isHDisabled: (-> not @isTrumpEnabled("H")).property("isEnabled", "contract", "level")
  isSDisabled: (-> not @isTrumpEnabled("S")).property("isEnabled", "contract", "level")
  isNTDisabled: (-> not @isTrumpEnabled("NT")).property("isEnabled", "contract", "level")

  isEnabled: (-> not @get("isCompleted")).property("isCompleted")
  isDisabled: (-> not @get("isEnabled")).property("isEnabled")

  isPassEnabled: (-> @get("isEnabled")).property("isEnabled")
  isPassDisabled: (-> not @get("isPassEnabled")).property("isPassEnabled")

  isDoubleEnabled: (->
    @get("isEnabled") and @get("contract")? and not @get("double")? and @get("currentSide") != @get("contract.side")
  ).property("isEnabled", "contract", "currentDirection", "double")
  isDoubleDisabled: (-> not @get("isDoubleEnabled")).property("isDoubleEnabled")

  isRedoubleEnabled: (->
    @get("isEnabled") and @get("contract")? and @get("double")? and not @get("redouble") and @get("currentSide") == @get("contract.side")
  ).property("isEnabled", "contract", "currentDirection", "double", "redouble")
  isRedoubleDisabled: (-> not @get("isRedoubleEnabled")).property("isRedoubleEnabled")

  isLevelEnabled: (level) ->
    @get("isEnabled") and (
      not @get("contract")? or
      @get("contract.level") < level or
      @get("contract.level") == level and @get("contract.trump") != "NT"
    )

  isTrumpEnabled: (trump) ->
    @get("isEnabled") and @get("level")? and (
      not @get("contract")? or
      @get("level") > @get("contract.level") or
      @get("level") == @get("contract.level") and Bridge.TRUMPS.indexOf(trump) > Bridge.TRUMPS.indexOf(@get("contract.trump"))
    )

  bid: (bid) ->
    @set("level", null)
    @get("controllers.auction").pushObject(Bridge.Bid.create(value: bid))

  bidPass: -> @bid("PASS")
  bidDouble: -> @bid("X")
  bidRedouble: -> @bid("XX")

  bid1: -> @set("level", 1)
  bid2: -> @set("level", 2)
  bid3: -> @set("level", 3)
  bid4: -> @set("level", 4)
  bid5: -> @set("level", 5)
  bid6: -> @set("level", 6)
  bid7: -> @set("level", 7)

  bidC: -> @bid(@get("level") + "C")
  bidD: -> @bid(@get("level") + "D")
  bidH: -> @bid(@get("level") + "H")
  bidS: -> @bid(@get("level") + "S")
  bidNT: -> @bid(@get("level") + "NT")
