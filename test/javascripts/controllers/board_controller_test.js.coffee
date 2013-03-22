#= require test_helper
#= require controllers/board_controller

describe "BoardController", ->
  describe "tricks", ->
    it "takes 4 cards into 1 trick", ->
      board = Bridge.BoardController.create()
      board.set("cards", ["H3", "H5", "H9", "HA", "SA"])
      assert.deepEqual board.get("tricks.firstObject"), ["H3", "H5", "H9", "HA"]

  describe "isTrickLead", ->
    it "returns true if no cards", ->
      board = Bridge.BoardController.create()
      assert.isTrue board.get("isTrickLead")

    it "returns true if 4 cards played", ->
      board = Bridge.BoardController.create()
      board.set("cards", ["H3", "H5", "H9", "HA"])
      assert.isTrue board.get("isTrickLead")

    it "returns false if 3 cards played", ->
      board = Bridge.BoardController.create()
      board.set("cards", ["H3", "H5", "H9"])
      assert.isFalse board.get("isTrickLead")

  describe "currentSuit", ->
    it "returns suit of first card in trick", ->
      board = Bridge.BoardController.create()
      board.set("cards", ["H3", "S5", "C9"])
      assert.strictEqual board.get("currentSuit"), "H"

    it "returns undefined when no current trick", ->
      board = Bridge.BoardController.create()
      board.set("cards", ["H3", "S5", "C9", "DA"])
      assert.isUndefined board.get("currentSuit")
