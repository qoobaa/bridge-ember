@Bridge.Tables = Ember.ArrayProxy.extend
  arrangedContent: (->
    @get("content").map (table, i) -> Bridge.Table.create(table)
  ).property("content")

  merge: (attributes) ->
    if table = @findProperty("id", attributes.id)
      table.setProperties(attributes)
    else
      @pushObject(Bridge.Table.create(attributes))

  remove: (attributes) ->
    if table = @findProperty("id", attributes.id)
      @removeObject(table)

  contentArrayWillChange: (content, index, removedCount, addedCount) ->
    if removedCount
      for i in [index..(index + removedCount - 1)]
        @get("arrangedContent").removeAt(i)

  contentArrayDidChange: (content, index, removedCount, addedCount) ->
    if addedCount
      for i in [index..(index + addedCount - 1)]
        @get("arrangedContent").insertAt(i, Bridge.Table.create(content.objectAt(i)))

