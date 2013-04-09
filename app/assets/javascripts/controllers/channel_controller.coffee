@Bridge.ChannelController = Ember.ObjectController.extend
  isReady: false

  init: ->
    @set("content", Bridge.Channel.create(urlBinding: "Bridge.env.socketUrl"))

  nameOrUserIdOrTableIdDidChange: (->
    @set("isReady", false)
    if @get("name")?
      channel = @get("content")
      tableId = @get("tableId")
      $.when(channel.register(tableId), channel.subscribe(tableId))
      .done =>
        @set("isReady", true)
  ).observes("name", "userId", "tableId")
