Ember.Application.initializer
  name: 'currentUser'

  initialize: (container) ->
    store = container.lookup('store:main')
    attributes = $('meta[name="current-user"]').attr('content')

    if attributes
      object = store.load(Dashboard.User, JSON.parse(attributes))
      user = Dashboard.User.find(object.id)

      controller = container.lookup('controller:currentUser').set('content', user)

      container.typeInjection('controller', 'currentUser', 'controller:currentUser')
