#= require ./vendor/jquery
#= require ./vendor/handlebars
#= require ./vendor/ember
#= require ./vendor/socket.io
#= require_self
#= require bridge

Ember.LOG_VERSION = false

@Bridge = Ember.Application.create
  ready: ->
    Bridge.env = Bridge.Env.create()
    Bridge.channel = Bridge.Channel.create(urlBinding: "Bridge.env.socketUrl", userIdBinding: "Bridge.env.userId")
    Bridge.store = Bridge.Store.create()

    Bridge.channel.on("tables/create", Bridge.store.tables.merge)
    Bridge.channel.on("tables/update", Bridge.store.tables.merge)
    Bridge.channel.on("tables/destroy", Bridge.store.tables.remove)
