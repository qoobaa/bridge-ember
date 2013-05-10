#= require sinon
#= require jquery
#= require bootstrap
#= require handlebars
#= require ember
#= require sockjs
#= require_self
#= require bridge

Konacha.reset = ->

Ember.LOG_VERSION = false

$("head", document).append('<meta content="http://localhost:5123/socket" name="socket-url">')
# $("head", document).append('<meta name="socket-id">')
# $("head", document).append('<meta name="user-id">')
# $("head", document).append('<meta name="user-email">')

Ember.run =>
  @Bridge = Ember.Application.create
    ready: ->
      Bridge.env = Bridge.Env.create()
      Bridge.session = Bridge.Session.create
        userIdBinding: "Bridge.env.userId"
        socketIdBinding: "Bridge.env.socketId"
        userEmailBinding: "Bridge.env.userEmail"

Bridge.setupForTesting()
Bridge.injectTestHelpers()

beforeEach (done) =>
  Ember.testing = true
  @server = sinon.fakeServer.create();

  Ember.run ->
    Bridge.advanceReadiness()

    Bridge.then ->
      done()

afterEach =>
  Bridge.reset()
  server.restore()
