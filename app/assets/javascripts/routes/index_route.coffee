Bridge.IndexRoute = Ember.Route.extend
  setupController: (controller, model) ->
    auction = Bridge.Auction.create(content: [], dealer: "N")
    play    = Bridge.Play.create(content: [])
    board   = Bridge.Board.create
      auction: auction
      play: play
      n: ["C2", "CQ", "CK", "D9", "DT", "DJ", "H2", "H6", "H7", "S4", "S6", "S9", "SA"]
      e: ["C4", "C5", "C7", "CT", "D3", "D5", "DQ", "H9", "HA", "S2", "S3", "S5", "S7"]
      s: ["D2", "D6", "D8", "DA", "H3", "H8", "HT", "HJ", "HQ", "HK", "S8", "SJ", "SQ"]
      w: ["C3", "C6", "C8", "C9", "CJ", "CA", "D4", "D7", "DK", "H4", "H5", "ST", "SK"]

    @controllerFor("bidding_box").setProperties(auction: auction)
    @controllerFor("trick").setProperties(play: play)
    @controllerFor("direction").setProperties(auction: auction, play: play)
    @controllerFor("summary").setProperties(auction: auction, play: play, dealer: "N", vulnerable: "NS")
    @controllerFor("hand_n").setProperties(initial: board.n, play: play)
    @controllerFor("hand_e").setProperties(initial: board.e, play: play)
    @controllerFor("hand_s").setProperties(initial: board.s, play: play)
    @controllerFor("hand_w").setProperties(initial: board.w, play: play)
