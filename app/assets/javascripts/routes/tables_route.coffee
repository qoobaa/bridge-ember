Bridge.TablesRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.env.get("userId")
