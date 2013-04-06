@Bridge.SessionController = Ember.Controller.extend
  isSignedInBinding: "Bridge.session.isSignedIn"

  signIn: ->
    Bridge.get("session").signIn(email: @get("email")).done =>
      @transitionToRoute("index")

  signOut: ->
    Bridge.get("session").signOut().done =>
      @transitionToRoute("signIn")
