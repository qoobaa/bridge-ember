#= require test_helper
#= require models/card

describe "Card", ->
  beforeEach =>
    @card = Bridge.Card.create content: "SA"

  it "returns suit", =>
    assert.strictEqual @card.get("suit"), "S"

  it "returns value", =>
    assert.strictEqual @card.get("value"), "A"
