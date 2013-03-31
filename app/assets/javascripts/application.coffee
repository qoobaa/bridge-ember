#= require ./vendor/jquery
#= require ./vendor/handlebars
#= require ./vendor/ember
#= require ./vendor/socket.io
#= require_self
#= require bridge

Ember.LOG_VERSION = false

@Bridge = Ember.Application.create()
