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
    $modal = $injector.get '$modal'

    # initialize formObject id
    if $scope.formObject.id is undefined
      $scope.formObject.id = $builder.config.max_id
      $builder.config.max_id = $builder.config.max_id + 1

    $scope.cancel = ->
      $scope.modalInstance.dismiss('cancel')

    $scope.save = (text) ->
      $scope.placeholder = text
      $scope.modalInstance.close()

    $scope.openSummerNote = ->
      $scope.modalInstance = $modal.open({
        template: '<div summernote ng-model="summerNoteText"></div>' +
                        '<button class="btn btn-danger btn-sm" ng-click="cancel()"></button>' +
                        '<button class="btn btn-success btn-sm" ng-click="save(summerNoteText)"></button>',
        scope: $scope
      })

    $scope.date = Date.now()

    $scope.formObject.logic = {
      hide: true
    }
    $builder.insertFormObject('skipLogic', $builder.forms.skipLogic.length + 1, $scope.formObject)
    countElements = 0
    for form of $builder.forms
            unless form is 'skipLogic'
                countElements = countElements + $builder.forms[form].length
    unless countElements is $builder.forms.skipLogic.length
        $builder.forms.skipLogic = []
        for form of $builder.forms
            unless form is 'skipLogic'
                angular.forEach($builder.forms[form], (element) ->
                    $builder.insertFormObject('skipLogic', $builder.forms.skipLogic.length + 1, element)
                    )
    countElements = 0


    $scope.fields = $builder.forms.skipLogic

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

        $scope.$watch '[label, description, placeholder, required, options, validation, multiple, minLength, maxLength, disableWeekends, maxDate, requireConfirmation, readOnly, minRange, maxRange, nextXDays, performCreditCheck, cprCountry, logic]', ->
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
