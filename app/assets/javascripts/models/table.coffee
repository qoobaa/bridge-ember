@Bridge.Table = Ember.Object.extend
  name: (-> "Table #{@get('id')}").property("id")
