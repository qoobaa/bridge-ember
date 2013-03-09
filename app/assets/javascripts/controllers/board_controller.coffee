@Bridge.BoardController = Ember.ObjectController.extend
  init: ->
    @_super.apply(@, arguments)
    @set "content", Bridge.Board.create
      state:
        bids: []
        cards: []
        dealer: "N"
        n: ["C2", "C3", "C4", "C5", "C6", "C7", "C8", "C9", "CT", "CJ", "CQ", "CK", "CA"]
        e: ["D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "DT", "DJ", "DQ", "DK", "DA"]
        s: ["H2", "H3", "H4", "H5", "H6", "H7", "H8", "H9", "HT", "HJ", "HQ", "HK", "HA"]
        w: ["S2", "S3", "S4", "S5", "S6", "S7", "S8", "S9", "ST", "SJ", "SQ", "SK", "SA"]
