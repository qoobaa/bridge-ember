@Bridge.Table = Ember.Object.extend
  name: (-> "Table #{@get('id')}").property("id")

  reload: ->
    $.ajax("/api/tables/#{@get('id')}")
    .done (payload) =>
      @setProperties(payload.table)

  save: ->
    $.ajax "/api/tables",
      type: "POST"
    .done (payload) =>
      @setProperties(payload.table)
