@Bridge.SignInController = Ember.Controller.extend
  signIn: ->
    $.post "/api/session", session: {email: @get("email")}, (data) =>
      Bridge.env.set("user_id", data.user_id)
      @transitionToRoute "index"
