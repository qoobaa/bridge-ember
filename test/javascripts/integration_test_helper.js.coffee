#= require sinon
#= require jquery
#= require bootstrap
#= require handlebars
#= require ember
#= require mocha-adapter
#= require sockjs
#= require_self
#= require bridge
#= require_tree ./helpers

Konacha.reset = Ember.K

Ember.LOG_VERSION = false
Ember.Test.adapter = Ember.Test.MochaAdapter.create()

$("head", document).append('<meta content="http://localhost:5123/socket" name="socket-url">')

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
  @server = sinon.fakeServer.create()
  @server.autoRespond = true

  Ember.run ->
    Bridge.advanceReadiness()

    Bridge.then ->
      done()

afterEach =>
  # Bridge.reset() # - throws error due to creating Session in Ember.Application.create ready hook
  server.restore()
