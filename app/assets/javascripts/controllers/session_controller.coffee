@Bridge.SessionController = Ember.Controller.extend
  isSignedIn: (->
    !!Bridge.get("env.userId")
  ).property("Bridge.env.userId")

  signIn: ->
    $.ajax "/api/session",
      type: "post"
      data: {session: {email: @get("email")}}
    .done (payload) =>
      Bridge.set("env.userId", payload.user.id)
      @transitionToRoute("index")

  signOut: ->
    $.ajax "/api/session",
      type: "delete"
    .done =>
      Bridge.set("env.userId", undefined)
      @transitionToRoute("signIn")
