@Bridge.Env = Ember.Object.extend
  csrfTokenDidChange: (->
    $.ajaxSettings.headers = {"X-CSRF-Token": @get("csrfToken")}
  ).observes("csrfToken")
