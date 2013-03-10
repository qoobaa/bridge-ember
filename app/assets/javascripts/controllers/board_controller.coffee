@Bridge.BoardController = Ember.ObjectController.extend
  init: ->
    @_super.apply(@, arguments)
    @set "content", Bridge.Board.create
      state:
        bids: []
        cards: []
        dealer: "N"
        n: ["C2", "S3", "H4", "D5", "C6", "C7", "C8", "C9", "CT", "CJ", "CQ", "CK", "CA"]
        e: ["D2", "C3", "S4", "H5", "D6", "D7", "D8", "D9", "DT", "DJ", "DQ", "DK", "DA"]
        s: ["H2", "D3", "C4", "S5", "H6", "H7", "H8", "H9", "HT", "HJ", "HQ", "HK", "HA"]
        w: ["S2", "H3", "D4", "C5", "S6", "S7", "S8", "S9", "ST", "SJ", "SQ", "SK", "SA"]
