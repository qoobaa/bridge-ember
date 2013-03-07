@Bridge.Bid = Ember.Object.extend
  isContract: (-> @get("value") in Bridge.CONTRACTS).property("value")
  isDouble: (-> @get("value") == Bridge.DOUBLE).property("value")
  isRedouble: (-> @get("value") == Bridge.REDOUBLE).property("value")
  isModifier: (-> @get("value") in Bridge.MODIFIERS).property("value")
  isPass: (-> @get("value") == Bridge.PASS).property("value")
  level: (-> parseInt(@get("value")[0], 10) if @get("isContract")).property("value")
  trump: (-> @get("value")[1..2] if @get("isContract")).property("value")
  side: (-> Bridge.SIDES[@get("direction")]).property("direction")

