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
