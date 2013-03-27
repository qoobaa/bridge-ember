@Bridge.Bid = Ember.Object.extend
  isContract: (-> /^\d/.test(@get("content"))).property("content")
  isPass: (-> @get("content") == "PASS").property("content")
  isDouble: (-> @get("content") == "X").property("content")
  isRedouble: (-> @get("content") == "XX").property("content")
  isModifier: (-> /^X/.test(@get("content"))).property("content")
  level: (-> parseInt(@get("content")[0], 10) if @get("isContract")).property("content", "isContract")
  trump: (-> @get("content")[1..-1] if @get("isContract")).property("content", "isContract")
  side: (-> if /N|S/.test(@get("direction")) then "NS" else "EW").property("direction")

  toString: -> @get("content")
