Bridge.SignInRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "index" if Bridge.get("env.userId")

  renderTemplate: ->
    @render "sign_in", controller: "session"
