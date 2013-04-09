@Bridge.IndexController = Ember.ArrayController.extend
  needs: ["channel"]

  isChannelReadyBinding: "controllers.channel.isReady"

  contentDidChange: (->
    @get("content")?.reload() if @get("isChannelReady")
  ).observes("content", "isChannelReady")

  createTable: ->
    Bridge.Table.create().save()
