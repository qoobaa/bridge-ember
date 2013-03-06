@Bridge.Bid = Ember.Object.extend
  isContract: (-> @get("value") in Bridge.CONTRACTS).property("value")
  isModifier: (-> @get("value") in Bridge.MODIFIERS).property("value")
  isPass: (-> @get("value") == Bridge.PASS).property("value")
  level: (-> @get("value")[0] if @get("isContract")).property("value")
  suit: (-> @get("value")[1..2] if @get("isContract")).property("value")
