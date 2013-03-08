@Bridge.Bid = Ember.Object.extend
  isContract: (-> @get("bid") in Bridge.CONTRACTS).property("bid")
  isDouble: (-> @get("bid") == Bridge.DOUBLE).property("bid")
  isRedouble: (-> @get("bid") == Bridge.REDOUBLE).property("bid")
  isModifier: (-> @get("bid") in Bridge.MODIFIERS).property("bid")
  isPass: (-> @get("bid") == Bridge.PASS).property("bid")
  level: (-> parseInt(@get("bid")[0], 10) if @get("isContract")).property("bid", "isContract")
  trump: (-> @get("bid")[1..2] if @get("isContract")).property("bid", "isContract")
  order: (-> Bridge.CONTRACTS.indexOf(@get("bid")) if @get("isContract")).property("bid", "isContract")
