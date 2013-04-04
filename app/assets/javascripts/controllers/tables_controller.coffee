@Bridge.TablesController = Ember.ArrayController.extend
  needs: []

  createTable: ->
    Bridge.Table.create().save()
