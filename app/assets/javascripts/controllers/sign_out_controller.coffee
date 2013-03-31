@Bridge.SignOutController = Ember.Controller.extend
  signOut: ->
    $.ajax
      url: "/api/session"
      type: "delete"
    .done =>
      Bridge.env.set("user_id", undefined)
      @transitionToRoute "signIn"
