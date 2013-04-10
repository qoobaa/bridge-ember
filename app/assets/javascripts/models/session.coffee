@Bridge.Session = Ember.Object.extend
  isSignedIn: (->
    !!@get("userId")
  ).property("userId")

  signIn: (credentials) ->
    $.ajax "/api/session",
      type: "post"
      data: session: credentials
    .done (payload) =>
      @setProperties
        userId: payload.user.id
        userEmail: payload.user.email
        socketId: payload.user.socket_id

  signOut: ->
    $.ajax "/api/session",
      type: "delete"
    .done =>
      @setProperties
        userId: undefined
        email: undefined
        socketId: undefined
