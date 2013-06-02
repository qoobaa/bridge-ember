#= require bootstrap
#= require handlebars
#= require ember
#= require sockjs
#= require_self
#= require bridge

Ember.LOG_VERSION = false

@Bridge = Ember.Application.create
  ready: ->
    Bridge.env = Bridge.Env.create()
    Bridge.session = Bridge.Session.create
      userIdBinding: "Bridge.env.userId"
      socketIdBinding: "Bridge.env.socketId"
      userEmailBinding: "Bridge.env.userEmail"
