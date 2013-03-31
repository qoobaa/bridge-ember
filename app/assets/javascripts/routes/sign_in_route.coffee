Bridge.SignInRoute = Ember.Route.extend
  renderTemplate: ->
    @render "sign_in", controller: "session"
