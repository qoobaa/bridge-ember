Bridge.TablesRoute = Ember.Route.extend
  model: ->
    Bridge.get("store.tables")

  redirect: ->
    @transitionTo "signIn" unless Bridge.env.get("userId")
