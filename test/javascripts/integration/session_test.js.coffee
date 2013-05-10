#= require integration_test_helper

describe "Session", ->
  it "signs in", (done) ->
    server.respondWith("POST", "/api/session",
      [201, "Content-Type": "application/json",
      JSON.stringify(session: {id: 1, email: "homer@simpson.com", socket_id: "123"})])

    Ember.run ->
      fillIn("input[placeholder='Email']", "homer@simpson.com").then ->
        click("button:contains('Sign in')")
      .then ->
        server.respond()
        assert.equal find(".nav button").text(), "homer@simpson.com"
        done()
