@Bridge.SessionController = Ember.Controller.extend
  isSignedIn: (->
    !!Bridge.env.get("userId")
  ).property("Bridge.env.userId")

  signIn: ->
    $.post "/api/session", session: {email: @get("email")}, (data) =>
      Bridge.env.set("userId", data.user_id)
      @transitionToRoute "index"

  signOut: ->
    $.ajax
      url: "/api/session"
      type: "delete"
    .done =>
      Bridge.env.set("userId", undefined)
      @transitionToRoute "signIn"
