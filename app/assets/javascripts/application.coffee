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
    Bridge.session = Bridge.Session.create(userId: Bridge.get("env.userId"))
    Bridge.channel = Bridge.Channel.create(urlBinding: "Bridge.env.socketUrl", userIdBinding: "Bridge.session.userId")
    Bridge.store = Bridge.Store.create()

    Bridge.channel.on("tables/create", (payload) -> Bridge.store.tables.merge(payload.table))
    Bridge.channel.on("tables/update", (payload) -> Bridge.store.tables.merge(payload.table))
    Bridge.channel.on("tables/destroy", (payload) -> Bridge.store.tables.remove(payload.table))
