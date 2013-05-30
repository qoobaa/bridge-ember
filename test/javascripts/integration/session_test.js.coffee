#= require integration_test_helper

describe "Session", ->
  it "signs in", ->
    server.respondWith "POST", "/api/session", (request) ->
      Ember.run ->
        request.respond(201, {"Content-Type": "application/json"}, JSON.stringify(session: {id: 1, email: "homer@simpson.com", socket_id: "123"}))

    server.respondWith "GET", "/api/tables", (request) ->
      Ember.run ->
        request.respond(200, {"Content-Type": "application/json"}, JSON.stringify({tables: []}))

    fillIn("input[placeholder='Email']", "homer@simpson.com")
    .click("button:contains('Sign in')").then ->
      assert.equal find(".nav button").text().trim(), "homer@simpson.com"
