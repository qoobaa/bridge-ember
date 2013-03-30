#= require test_helper
#= require lib/utils

describe "Utils", ->
  describe "sortCardSuits", ->
    it "SHCD without trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "D", "H", "S"]), ["S", "H", "C", "D"]

    it "SHC without trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "H", "S"]), ["S", "H", "C"]

    it "HCD without trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "D", "H"]), ["H", "C", "D"]

    it "HSD without trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["D", "H", "S"]), ["H", "S", "D"]

    it "SDC without trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "D", "S"]), ["S", "D", "C"]

    it "SH without trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["H", "S"]), ["S", "H"]

    it "SD without trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["D", "S"]), ["S", "D"]

    it "CD without trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "D"]), ["C", "D"]

    it "SHCD with S trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "D", "H", "S"], "S"), ["S", "H", "C", "D"]

    it "HSDC with H trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "D", "H", "S"], "H"), ["H", "S", "D", "C"]

    it "DSHC with D trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "D", "H", "S"], "D"), ["D", "S", "H", "C"]

    it "CHSD with C trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "D", "H", "S"], "C"), ["C", "H", "S", "D"]

    it "SHC with S trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "H", "S"], "S"), ["S", "H", "C"]

    it "HSC with H trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "H", "S"], "H"), ["H", "S", "C"]

    it "SHD with S trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["D", "H", "S"], "S"), ["S", "H", "D"]

    it "DSH with D trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["D", "H", "S"], "D"), ["D", "S", "H"]

    it "SH with S trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["H", "S"], "S"), ["S", "H"]

    it "HS with H trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["H", "S"], "H"), ["H", "S"]

    it "CS with C trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["C", "S"], "C"), ["C", "S"]

    it "DH with D trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["D", "H"], "D"), ["D", "H"]

    it "SD with C trump", ->
      assert.deepEqual Bridge.Utils.sortCardSuits(["D", "S"], "C"), ["S", "D"]

  describe "sortCards", ->
    it "SAKJT2-H84-CT98-DAKQ without trump", ->
      hand   = ["C8", "C9", "CT", "DQ", "DK", "DA", "H4", "H8", "S2", "ST", "SJ", "SK", "SA"]
      sorted = ["SA", "SK", "SJ", "ST", "S2", "H8", "H4", "CT", "C9", "C8", "DA", "DK", "DQ"]
      assert.deepEqual Bridge.Utils.sortCards(hand), sorted

    it "DAKJT2-S84-HT98-CAKQ with D trump", ->
      hand   = ["CQ", "CK", "CA", "D2", "DT", "DJ", "DK", "DA", "H8", "H9", "HT", "S4", "S8"]
      sorted = ["DA", "DK", "DJ", "DT", "D2", "S8", "S4", "HT", "H9", "H8", "CA", "CK", "CQ"]
      assert.deepEqual Bridge.Utils.sortCards(hand, "D"), sorted

  describe "trickWinner", ->
    it "CA from [C2, H2, CK, CA]", ->
      assert.strictEqual Bridge.Utils.trickWinner(["C2", "H2", "CK", "CA"]), "CA"

    it "H2 from [C2, H2, CK, CA] with H trump", ->
      assert.strictEqual Bridge.Utils.trickWinner(["C2", "H2", "CK", "CA"], "H"), "H2"

    it "DA from [D9, D3, DA, D4] with no trump", ->
      assert.strictEqual Bridge.Utils.trickWinner(["D9", "D3", "DA", "D4"], "NT"), "DA"

  describe "score", ->
    it "0 when 4HE and 10 tricks taken", ->
      assert.strictEqual Bridge.Utils.score("4HE", 10), 0

    it "2 when 4HE and 11 tricks taken", ->
      assert.strictEqual Bridge.Utils.score("4HE", 12), 2

    it "-2 when 4NTXE and 8 tricks taken", ->
      assert.strictEqual Bridge.Utils.score("4HE", 8), -2

  describe "playDirections", ->
    it "return correct directions for D9, D3, DA, D4 with declarer N and no trump", ->
      assert.deepEqual Bridge.Utils.playDirections("N", "NT", ["D9", "D3", "DA", "D4", ""]), ["E", "S", "W", "N", "W"]

    it "return correct directions for D3, DA, D4, D9 with declarer N and no trump", ->
      assert.deepEqual Bridge.Utils.playDirections("N", "NT", ["D3", "DA", "D4", "D9", ""]), ["E", "S", "W", "N", "S"]

  describe "auctionContract", ->
    it "4NTXXN from [1NT, PASS, 4NT, X, XX] with N declarer", ->
      assert.strictEqual Bridge.Utils.auctionContract("N", ["1NT", "PASS", "4NT", "X", "XX"]), "4NTXXN"

    it "no contract from [PASS PASS PASS PASS] with N declarer", ->
      assert.isUndefined Bridge.Utils.auctionContract("N", ["PASS", "PASS", "PASS", "PASS"])
