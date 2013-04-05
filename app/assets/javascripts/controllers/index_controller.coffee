@Bridge.IndexController = Ember.ArrayController.extend
  contentDidChange: (->
    @get("content")?.reload()
  ).observes("content")

  createTable: ->
    Bridge.Table.create().save()
