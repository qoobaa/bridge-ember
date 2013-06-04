@Helpers = @Helpers || {}
@Helpers.signIn = (email = "john@doe.com") ->
  server.respondWith "POST", "/api/session", (request) ->
    Ember.run ->
      request.respond(201, {"Content-Type": "application/json"}, JSON.stringify(session: {id: 1, email: email, socket_id: "123"}))

  server.respondWith "GET", "/api/tables", (request) ->
    Ember.run ->
      request.respond(200, {"Content-Type": "application/json"}, JSON.stringify({tables: []}))

  fillIn("input[placeholder='Email']", email)
  .click("button:contains('Sign in')")
