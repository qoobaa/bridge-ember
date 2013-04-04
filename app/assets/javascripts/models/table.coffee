@Bridge.Table = Ember.Object.extend
  name: (-> "Table #{@get('id')}").property("id")

  save: ->
    $.ajax "/api/tables",
      type: "POST"
      success: (table) => @setProperties(table)
