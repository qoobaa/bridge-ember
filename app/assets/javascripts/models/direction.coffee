@Bridge.Direction = Ember.Object.extend
  index: (-> Bridge.DIRECTIONS.indexOf(@get("content"))).property("content")
  next: (-> Bridge.Direction.create(content: Bridge.DIRECTIONS[(@get("index") + 1) % 4])).property("index")
  opposite: (-> Bridge.Direction.create(content: Bridge.DIRECTIONS[(@get("index") + 2) % 4])).property("index")
  previous: (-> Bridge.Direction.create(content: Bridge.DIRECTIONS[(@get("index") + 3) % 4])).property("index")
  side: (-> Bridge.SIDES[@get("index") % 2]).property("index")

@Bridge.Direction.wrap = (content) -> Bridge.Direction.create(content: content)
