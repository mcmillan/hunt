angular.module('hunt')

.service 'hunt', ($http, $q, session) ->
  get = (url) ->
    $http
      method: 'get'
      url: '/assets/mocks' + url

  service =
    api:
      properties:
        list: ->
          get '/properties.json'

        view: (properyID) ->
          get '/property.json'

      users:
        view: (userID) ->
          get '/user.json'

      hunts:
        list: (userID) ->
          dfd = $q.defer()

          get('/hunt.json')
          service.api.hunts.view()
            .success (hunt) ->
              dfd.resolve [hunt]
            .error (data) ->
              dfd.reject data

          success:
            dfd.promise.then
          error:
            dfd.promise.catch

        view: (huntID) ->
          get('/hunt.json')
            .success (hunt) ->
              service.api.properties.view()
                .success (property) ->
                  hunt.properties.push property

              service.api.users.view()
                .success (user) ->
                  hunt.users.push user



