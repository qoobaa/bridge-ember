Bridge.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.env.get("userId")

  model: ->
    Bridge.Board.create
      dealer: "N"
      vulnerable: "NS"
      auction: Bridge.Auction.create(content: [], dealer: "N")
      play: Bridge.Play.create(content: [])
      n: ["C2", "CQ", "CK", "D9", "DT", "DJ", "H2", "H6", "H7", "S4", "S6", "S9", "SA"]
      e: ["C4", "C5", "C7", "CT", "D3", "D5", "DQ", "H9", "HA", "S2", "S3", "S5", "S7"]
      s: ["D2", "D6", "D8", "DA", "H3", "H8", "HT", "HJ", "HQ", "HK", "S8", "SJ", "SQ"]
      w: ["C3", "C6", "C8", "C9", "CJ", "CA", "D4", "D7", "DK", "H4", "H5", "ST", "SK"]

  setupController: (controller, board) ->
    @controllerFor("bidding_box").setProperties(auction: board.get("auction"))
    @controllerFor("trick").setProperties(play: board.get("play"))
    @controllerFor("direction").setProperties(auction: board.get("auction"), play: board.get("play"))
    @controllerFor("hand_n").setProperties(initial: board.get("n"), play: board.get("play"))
    @controllerFor("hand_e").setProperties(initial: board.get("e"), play: board.get("play"))
    @controllerFor("hand_s").setProperties(initial: board.get("s"), play: board.get("play"))
    @controllerFor("hand_w").setProperties(initial: board.get("w"), play: board.get("play"))
    @controllerFor("summary").setProperties
      auction: board.get("auction")
      play: board.get("play")
      dealer: board.get("dealer")
      vulnerable: board.get("vulnerable")
