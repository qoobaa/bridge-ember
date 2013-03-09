#= require test_helper
#= require models/bid

describe "Bid", ->
  describe "isContract", ->
    it "returns true for 1NT", ->
      bid = Bridge.Bid.create bid: "1NT"
      assert.isTrue bid.get("isContract")

    it "returns false for PASS", ->
      bid = Bridge.Bid.create bid: "PASS"
      assert.isFalse bid.get("isContract")

  describe "isDouble", ->
    it "returns true for X", ->
      bid = Bridge.Bid.create bid: "X"
      assert.isTrue bid.get("isDouble")

    it "returns false for PASS", ->
      bid = Bridge.Bid.create bid: "PASS"
      assert.isFalse bid.get("isDouble")

  describe "isRedouble", ->
    it "returns true for XX", ->
      bid = Bridge.Bid.create bid: "XX"
      assert.isTrue bid.get("isRedouble")

    it "returns false for 1S", ->
      bid = Bridge.Bid.create bid: "1S"
      assert.isFalse bid.get("isRedouble")

  describe "isModifier", ->
    it "returns true for XX", ->
      bid = Bridge.Bid.create bid: "XX"
      assert.isTrue bid.get("isModifier")

    it "returns false for PASS", ->
      bid = Bridge.Bid.create bid: "PASS"
      assert.isFalse bid.get("isModifier")

  describe "isPass", ->
    it "returns true for PASS", ->
      bid = Bridge.Bid.create bid: "PASS"
      assert.isTrue bid.get("isPass")

    it "returns false for X", ->
      bid = Bridge.Bid.create bid: "X"
      assert.isFalse bid.get("isPass")

  describe "level", ->
    it "returns 2 for 2H", ->
      bid = Bridge.Bid.create bid: "2H"
      assert.strictEqual bid.get("level"), 2

    it "returns undefined for PASS", ->
      bid = Bridge.Bid.create bid: "PASS"
      assert.strictEqual bid.get("level"), undefined

  describe "trump", ->
    it "returns NT for 2NT", ->
      bid = Bridge.Bid.create bid: "2NT"
      assert.strictEqual bid.get("trump"), "NT"

    it "returns undefined for PASS", ->
      bid = Bridge.Bid.create bid: "PASS"
      assert.strictEqual bid.get("trump"), undefined

  describe "order", ->
    it "returns 18 for 4S", ->
      bid = Bridge.Bid.create bid: "4S"
      assert.strictEqual bid.get("order"), 18

    it "returns undefined for PASS", ->
      bid = Bridge.Bid.create bid: "PASS"
      assert.strictEqual bid.get("order"), undefined
