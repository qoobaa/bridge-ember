@Bridge.Direction = Ember.Object.extend
  index: (-> Bridge.DIRECTIONS.indexOf(@get("direction"))).property("direction")
  next: (-> Bridge.Direction.create(direction: Bridge.DIRECTIONS[(@get("index") + 1) % 4])).property("index")
  opposite: (-> Bridge.Direction.create(direction: Bridge.DIRECTIONS[(@get("index") + 2) % 4])).property("index")
  previous: (-> Bridge.Direction.create(direction: Bridge.DIRECTIONS[(@get("index") + 3) % 4])).property("index")
  side: (-> Bridge.SIDES[@get("index") % 2]).property("index")

@Bridge.Direction.wrap = (direction) -> Bridge.Direction.create(direction: direction)
