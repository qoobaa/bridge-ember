@Bridge.Session = Ember.Object.extend
  isSignedIn: (->
    !!@get("userId")
  ).property("userId")

  signIn: (credentials) ->
    $.ajax "/api/session",
      type: "post"
      data: session: credentials
    .done (payload) =>
      @set("userId", payload.user.id)

  signOut: ->
    $.ajax "/api/session",
      type: "delete"
    .done =>
      @set("userId", undefined)
