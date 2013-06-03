@Bridge.IndexController = Ember.ArrayController.extend
  needs: ["stream"]

  createTable: ->
    Bridge.Table.create().save()
