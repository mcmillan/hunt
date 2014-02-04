angular.module 'hunt'

.config ($stateProvider, resourceRouterProvider) ->
  resourceRouterProvider.mount $stateProvider,
    path: ['properties']
    views: ['index', 'show', 'new', 'edit']

.run (session, $rootScope) ->
    $rootScope.propertyPredicates = session.propertyPredicates = [
      {slug: 'favourite', name: 'Favourite'}
      {slug: 'price', name: 'Price'}
      {slug: 'date', name: 'Date'}
    ]

.controller 'PropertyListCtrl', ($scope, hunt) ->
  $scope.properties = []

  hunt.api.properties.list()
    .success (data) ->
      $scope.properties = data

.controller 'PropertyViewCtrl', ($scope, $stateParams, hunt) ->
  $scope.property = {}

  hunt.api.properties.view($stateParams.propertyID)
    .success (data) ->
      $scope.property = data

.directive 'propertyProgress', ->
  restrict: 'E'
  scope:
    stage: '='

.directive 'propertyThumb', ->
  restrict: 'E'
  scope:
    property: '='
  templateUrl: "hunt/properties/thumb.html"

.directive 'propertyCard', ->
  restrict: 'E'
  scope:
    property: '='
  templateUrl: "hunt/properties/card.html"

.directive 'propertyList', ->
  restrict: 'E'
  scope:
    properties: '='
  templateUrl: 'hunt/properties/list.html'
  controller: ($scope) ->
    $scope.predicates = [
      {slug: 'favourite', name: 'Favourite'}
      {slug: 'price', name: 'Price'}
      {slug: 'date', name: 'Date'}
    ]

