#= require test_helper
#= require models/card

describe "Card", ->
  beforeEach =>
    @card = Bridge.Card.create card: "SA"

  it "returns suit", =>
    assert.strictEqual @card.get("suit"), "S"

  it "returns value", =>
    assert.strictEqual @card.get("value"), "A"

  it "returns order", =>
    assert.strictEqual @card.get("order"), 12
