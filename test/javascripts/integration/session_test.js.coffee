#= require integration_test_helper

describe "Session", ->
  it "signs in", ->
    Helpers.signIn("homer@simpson.com").then ->
      assert.equal find(".nav button").text().trim(), "homer@simpson.com"

  it "signs out", ->
    server.respondWith "DELETE", "/api/session", (request) ->
      Ember.run ->
        request.respond(200, {"Content-Type": "application/json"}, "{}")

    Helpers.signIn("homer@simpson.com")
    .click(".navbar .caret")
    .click(".navbar a:contains('Sign out')").then ->
      assert.equal find("input[placeholder='Email']").val(), ""
