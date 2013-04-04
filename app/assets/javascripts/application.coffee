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

    Bridge.channel.on("tables/create", (a) -> Bridge.store.tables.merge(a))
    Bridge.channel.on("tables/update", (a) -> Bridge.store.tables.merge(a))
    Bridge.channel.on("tables/destroy", (a) -> Bridge.store.tables.remove(a))
