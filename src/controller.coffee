# ----------------------------------------
# Shared functions
# ----------------------------------------
copyObjectToScope = (object, scope) ->
    ###
    Copy object (ng-repeat="object in objects") to scope without `hashKey`.
    ###
    for key, value of object when key isnt '$$hashKey'
        # copy object.{} to scope.{}
        scope[key] = value
    return


# ----------------------------------------
# builder.controller
# ----------------------------------------
angular.module 'builder.controller', ['builder.provider']

# ----------------------------------------
# fbFormObjectEditableController
# ----------------------------------------
.controller 'fbFormObjectEditableController', ['$scope', '$injector', ($scope, $injector) ->
    $builder = $injector.get '$builder'
    $uibModal = $injector.get '$uibModal'
    $filter = $injector.get '$filter'

    $scope.newRule = {}

    if !$scope.formObject.pointRules?
      $scope.formObject.pointRules = []

    switch $scope.formObject.component
      when 'checkbox'
        $scope.predicates = [{value: 'in',label: 'In'  },{value: 'not_in',label: 'Not in'},{value: 'null',label: 'Empty'},{value: 'not_null', label: 'Not Empty'}]
      when 'radio'
        $scope.predicates = [{value: 'eq',label: 'Equals'},{value: 'not_eq',label: 'Does not equal'},{value: 'does_not_match',label: 'Does not match'},{value: 'contains',label: 'Contains'},{value: 'does_not_contain',label: 'Does not contain'},{value: 'lt',label: 'Less than'},{value: 'lteq',label: 'Less than or equal to'},{value: 'gt',label: 'Greater than'},{value: 'gteq',label: 'Greater than or equal to'},{value: 'null',label: 'Empty'},{valu: 'not_null',label: 'Not empty'}]
      when 'select'
        $scope.predicates = [{value: 'eq',label: 'Equals'},{value: 'not_eq',label: 'Does not equal'},{value: 'does_not_match',label: 'Does not match'},{value: 'contains',label: 'Contains'},{value: 'does_not_contain',label: 'Does not contain'},{value: 'lt',label: 'Less than'},{value: 'lteq',label: 'Less than or equal to'},{value: 'gt',label: 'Greater than'},{value: 'gteq',label: 'Greater than or equal to'},{value: 'null',label: 'Empty'},{valu: 'not_null',label: 'Not empty'}]
      when 'product'
        $scope.predicates = [{value: 'eq',label: 'Equals'},{value: 'not_eq',label: 'Does not equal'},{value: 'in',label: 'In'},{value: 'not_in',label: 'Not in'},{value: 'null',label: 'Empty'},{value: 'not_null',label: 'Not empty'}]
      when 'email'
        $scope.predicates = [{value: 'eq',label: 'Equals'},{value: 'not_eq',label: 'Does not equal'},{value: 'matches',label: 'Matches'},{value: 'does_not_match',label: 'Does not match'},{value: 'contains',label: 'Contains'},{value: 'does_not_contain',label: 'Does not contain'},{value: 'null',label: 'Empty'},{value: 'not_null',label: 'Not empty'}]
      when 'area'
        $scope.predicates = [{value: 'eq',label: 'Equals'},{value: 'not_eq',label: 'Does not equal'},{value: 'matches',label: 'Matches'},{value: 'does_not_match',label: 'Does not match'},{value: 'contains',label: 'Contains'},{value: 'does_not_contain',label: 'Does not contain'},{value: 'null',label: 'Empty'},{value: 'not_null',label: 'Not empty'}]
      when 'phone'
        $scope.predicates = [{value: 'eq',label: 'Equals'},{value: 'not_eq',label: 'Does not equal'},{value: 'matches',label: 'Matches'},{value: 'does_not_match',label: 'Does not match'},{value: 'contains',label: 'Contains'},{value: 'does_not_contain',label: 'Does not contain'},{value: 'null',label: 'Empty'},{value: 'not_null',label: 'Not empty'}]
      when 'text'
        $scope.predicates = [{value: 'eq',label: 'Equals'},{value: 'not_eq',label: 'Does not equal'},{value: 'matches',label: 'Matches'},{value: 'does_not_match',label: 'Does not match'},{value: 'contains',label: 'Contains'},{value: 'does_not_contain',label: 'Does not contain'},{value: 'null',label: 'Empty'},{value: 'not_null',label: 'Not empty'},{value: 'lt',label: 'Less than'},{value: 'lteq',label: 'Less than or equal to'},{value: 'gt',label: 'Greater than'},{value: 'gteq',label: 'Greater than or equal to'}]
      when 'date'
        $scope.predicates = [{value: 'lt',label: 'Less than'},{value: 'lteq',label: 'Less than or equal to'},{value: 'gt',label: 'Greater than'},{value: 'gteq',label: 'Greater than or equal to'},{value: 'null',label: 'Empty'},{value: 'not_null',label: 'Not empty'}]
      when 'signature'
        $scope.predicates = [{value: 'null',label: 'Empty'},{value: 'not_null',label: 'Not empty'}]
      when 'upload'
        $scope.predicates = [{value: 'null',label: 'Empty'},{value: 'not_null',label: 'Not empty'}]
      when 'cpr'
        $scope.predicates = [{value: 'null',label: 'Empty'},{value: 'not_null',label: 'Not empty'}]
      when 'address'
        $scope.predicates = [{value: 'null',label: 'Empty'},{value: 'not_null',label: 'Not empty'}]

    $scope.addRule = ->
      if !$scope.newRule.predicate? or !$scope.newRule.points or (!$scope.newRule.value? and $scope.newRule.predicate isnt 'null' and $scope.newRule.predicate isnt 'not_null')
          $scope.rulesErrorMessage = 'Please update all fields.'
      else
        $scope.rulesErrorMessage = ''
        if (angular.isDate($scope.newRule.value))
          $scope.newRule.value = $filter('date')($scope.newRule.value, 'dd-MM-yyyy')
        $scope.formObject.pointRules.push $scope.newRule
        $scope.newRule = {}

    $scope.removeRule = (rule) ->
      $scope.formObject.pointRules.splice($scope.formObject.pointRules.indexOf(rule),1)

    if !$scope.formObject.logic?
      $scope.formObject.logic = {
        action: 'Hide'
      }
    else
      if $scope.formObject.logic.component?
        $scope.formObject.logic.component = angular.fromJson($scope.formObject.logic.component)

    # initialize formObject id
    if $scope.formObject.id is undefined
      $scope.formObject.id = $builder.config.max_id
      $builder.config.max_id = $builder.config.max_id + 1

    $scope.actions = ['Hide', 'Show']

    $scope.$watch 'formObject.logic.component', ->
      if $scope.formObject.logic.component?
        objectized = angular.fromJson($scope.formObject.logic.component)
        switch objectized.component
          when 'message'
            $scope.comparatorChoices = []
          when 'email'
            $scope.comparatorChoices = []
          when 'date'
            $scope.comparatorChoices = ['Equal to', 'Not equal to', 'Less than', 'Less than or equal to', 'Greater than', 'Greater than or equal to']
          when 'text'
            $scope.comparatorChoices = ['Equal to', 'Not equal to', 'Contains', 'Does not contain', 'Less than', 'Less than or equal to', 'Greater than', 'Greater than or equal to']
          when 'area'
            $scope.comparatorChoices = ['Contains', 'Does not contain']
          when 'checkbox'
            $scope.comparatorChoices = ['Contains', 'Does not contain']
          when 'radio'
            $scope.comparatorChoices = ['Equal to', 'Not equal to']
          when 'select'
            $scope.comparatorChoices = ['Equal to', 'Not equal to', 'Contains', 'Does not contain']
          when 'upload'
            $scope.comparatorChoices = []
          when 'signature'
            $scope.comparatorChoices = []
          when 'address'
            $scope.comparatorChoices = ['Contains', 'Does not contain']
          when 'cpr'
            $scope.comparatorChoices = ['Contains', 'Does not contain']
          when 'graphic'
            $scope.comparatorChoices = ['Equal to', 'Not equal to', 'Contains', 'Does not contain']
          when 'product'
            $scope.comparatorChoices = ['Equal to', 'Not equal to', 'Contains', 'Does not contain']

    $scope.cancel = ->
      $scope.modalInstance.dismiss('cancel')

    $scope.save = (text) ->
      $scope.placeholder = text
      $scope.modalInstance.close()

    $scope.openPoints = ($event) ->
      $event.preventDefault()
      $event.stopPropagation()
      $scope.openedPoints = yes

    $scope.resetLogic = () ->
      $scope.formObject.logic = {
        action: 'Hide'
      }

    $scope.openSummerNote = ->
      $scope.summerNoteText = $scope.formObject.placeholder;
      $scope.modalInstance = $uibModal.open({
        template:   '<div class="modal-header">'+
                        '<button type="button" class="close" ng-click="cancel()"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>'+
                        '<h4 class="modal-title">Edit Rich Content</div>'+
                    '</div>'+
                    '<div class="modal-body no-padding">'+
                        '<div summernote ng-model="summerNoteText"></div>' +
                    '</div>'+
                    '<div class="modal-footer">'+
                        '<button class="btn btn-white pull-left" ng-click="cancel()">Cancel</button>' +
                        '<button class="btn btn-primary pull-right" ng-click="save(summerNoteText)">Apply</button>'+
                    '</div>',
        scope: $scope
      })

    $scope.date = Date.now()

    # if i can get the name of the current form
    # then i can see the previous forms
    # i can get previous elements from $builder.forms by their index
    for form of $builder.forms

      # comment this afterwards
      inThisForm = $builder.forms[form].filter (item) ->
        item.id is $scope.formObject.id

      if inThisForm.length > 0
        $scope.currentForm = form

    # old canSee func, moved to inline
    $scope.keys = Object.keys $builder.forms

    $scope.setupScope = (formObject) ->
        ###
        1. Copy origin formObject (ng-repeat="object in formObjects") to scope.
        2. Setup optionsText with formObject.options.
        3. Watch scope.label, .description, .placeholder, .required, .options then copy to origin formObject.
        4. Watch scope.optionsText then convert to scope.options.
        5. setup validationOptions
        ###
        copyObjectToScope formObject, $scope

        $scope.optionsText = formObject.options.join '\n'

        $scope.$watch '[label, description, placeholder, required, options, validation, multiple, minLength, maxLength, disableWeekends, maxDate, requireConfirmation, readOnly, minRange, maxRange, nextXDays, performCreditCheck, cprCountry, logic, category, pointRules, conversionType]', ->
            formObject.label = $scope.label
            formObject.description = $scope.description
            formObject.placeholder = $scope.placeholder
            formObject.required = $scope.required
            formObject.options = $scope.options
            formObject.multiple = $scope.multiple
            formObject.validation = $scope.validation
            formObject.minLength = $scope.minLength
            formObject.maxLength = $scope.maxLength
            formObject.disableWeekends = $scope.disableWeekends
            formObject.maxDate = $scope.maxDate
            formObject.requireConfirmation = $scope.requireConfirmation
            formObject.readOnly = $scope.readOnly
            formObject.minRange = $scope.minRange
            formObject.maxRange = $scope.maxRange
            formObject.nextXDays = $scope.nextXDays
            formObject.performCreditCheck = $scope.performCreditCheck
            formObject.cprCountry = $scope.cprCountry
            formObject.logic = $scope.logic
            formObject.category = $scope.category
            formObject.pointRules = $scope.pointRules
            formObject.conversionType = $scope.conversionType

        , yes

        $scope.$watch 'optionsText', (text) ->
            $scope.options = (x for x in text.split('\n') when x.length > 0)
            $scope.inputText = $scope.options[0]

        component = $builder.components[formObject.component]
        $scope.validationOptions = component.validationOptions

    $scope.data =
        model: null
        backup: ->
            ###
            Backup input value.
            ###
            @model =
                label: $scope.label
                description: $scope.description
                placeholder: $scope.placeholder
                required: $scope.required
                optionsText: $scope.optionsText
                validation: $scope.validation
                multiple: $scope.multiple
                minLength: $scope.minLength
                maxLength: $scope.maxLength
                disableWeekends: $scope.disableWeekends
                maxDate: $scope.maxDate
                requireConfirmation: $scope.requireConfirmation
                readOnly: $scope.readOnly
                minRange: $scope.minRange
                maxRange: $scope.maxRange
                nextXDays: $scope.nextXDays
                performCreditCheck: $scope.performCreditCheck
                cprCountry: $scope.cprCountry
                logic: $scope.logic
                category: $scope.category
                pointRules: $scope.pointRules
                conversionType: $scope.conversionType
        rollback: ->
            ###
            Rollback input value.
            ###
            return if not @model
            $scope.label = @model.label
            $scope.description = @model.description
            $scope.placeholder = @model.placeholder
            $scope.required = @model.required
            $scope.optionsText = @model.optionsText
            $scope.validation = @model.validation
            $scope.multiple = @model.multiple
            $scope.minLength = @model.minLength
            $scope.maxLength = @model.maxLength
            $scope.disableWeekends = @model.disableWeekends
            $scope.maxDate = @model.maxDate
            $scope.requireConfirmation = @model.requireConfirmation
            $scope.readOnly = @model.readOnly
            $scope.minRange = @model.minRange
            $scope.maxRange = @model.maxRange
            $scope.nextXDays = @model.nextXDays
            $scope.performCreditCheck = @model.performCreditCheck
            $scope.cprCountry = @model.cprCountry
            $scope.logic = @model.logic
            $scope.category = @model.category
            $scope.pointRules = @model.pointRules
            $scope.conversionType = @model.conversionType
]

# ----------------------------------------
# fbComponentsController
# ----------------------------------------
.controller 'fbComponentsController', ['$scope', '$injector', ($scope, $injector) ->
    # providers
    $builder = $injector.get '$builder'

    # action
    $scope.selectGroup = ($event, group) ->
        $event?.preventDefault()
        $scope.activeGroup = group
        $scope.components = []
        for name, component of $builder.components when component.group is group
            $scope.components.push component

    $scope.groups = $builder.groups
    $scope.activeGroup = $scope.groups[0]
    $scope.allComponents = $builder.components
    $scope.$watch 'allComponents', -> $scope.selectGroup null, $scope.activeGroup
]


# ----------------------------------------
# fbComponentController
# ----------------------------------------
.controller 'fbComponentController', ['$scope', ($scope) ->
    $scope.copyObjectToScope = (object) -> copyObjectToScope object, $scope
]


# ----------------------------------------
# fbFormController
# ----------------------------------------
.controller 'fbFormController', ['$scope', '$injector', ($scope, $injector) ->
    # providers
    $builder = $injector.get '$builder'
    $timeout = $injector.get '$timeout'
    $rootScope = $injector.get '$rootScope'

    $rootScope.fields = $builder.forms

    # set default for input
    $scope.input ?= []
    $scope.$watch 'form', ->
        # remove superfluous input
        if $scope.input.length > $scope.form.length
            $scope.input.splice $scope.form.length
        # tell children to update input value.
        # ! use $timeout for waiting $scope updated.
        $timeout ->
            $scope.$broadcast $builder.broadcastChannel.updateInput
    , yes
]


# ----------------------------------------
# fbFormObjectController
# ----------------------------------------
.controller 'fbFormObjectController', ['$scope', '$injector', ($scope, $injector) ->
    # providers
    $builder = $injector.get '$builder'

    $scope.copyObjectToScope = (object) -> copyObjectToScope object, $scope

    $scope.updateInput = (value) ->
        ###
        Copy current scope.input[X] to $parent.input.
        @param value: The input value.
        ###
        input =
            id: $scope.formObject.id
            label: $scope.formObject.label
            value: value ? ''
        $scope.$parent.input.splice $scope.$index, 1, input
]
