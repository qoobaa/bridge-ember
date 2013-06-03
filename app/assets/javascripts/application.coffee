#= require bootstrap
#= require handlebars
#= require ember
#= require eventsource
#= require_self
#= require bridge

Ember.LOG_VERSION = false

@Bridge = Ember.Application.create
  ready: ->
    Bridge.env = Bridge.Env.create()
    Bridge.session = Bridge.Session.create
      userIdBinding: "Bridge.env.userId"
      userEmailBinding: "Bridge.env.userEmail"
