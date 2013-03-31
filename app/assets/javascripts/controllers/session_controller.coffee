@Bridge.SessionController = Ember.Controller.extend
  signIn: ->
    $.post "/api/session", session: {email: @get("email")}, (data) =>
      Bridge.env.set("user_id", data.user_id)
      @transitionToRoute "index"

  signOut: ->
    $.ajax
      url: "/api/session"
      type: "delete"
    .done =>
      Bridge.env.set("user_id", undefined)
      @transitionToRoute "signIn"
