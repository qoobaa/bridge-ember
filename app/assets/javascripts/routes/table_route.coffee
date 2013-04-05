Bridge.TableRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("env.userId")

  model: (params) ->
    Bridge.Table.create(id: params.table_id)

  serialize: (model) ->
    table_id: model.get("id")

  activate: ->

  deactivate: ->
