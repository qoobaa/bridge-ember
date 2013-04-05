@Bridge.TableController = Ember.Controller.extend
  contentDidChange: (->
    @get("content")?.reload()
  ).observes("content")
