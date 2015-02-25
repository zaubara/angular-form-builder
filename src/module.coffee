angular.module 'builder', ['builder.directive']
    .run ($validator) ->
        $validator.register('text', {
                invoke: 'watch'
                validator: (value, scope, element, attrs, $injector) ->
                    scope.minLength is 0 || (value.length >= scope.minLength && value.length <= scope.maxLength)
                error: 'There\'s a length restriction on this field'
            })
        $validator.register('numberRange', {
                invoke: 'watch'
                validator: (value, scope, element, attrs, $injector) ->
                    value >= scope.minRange && value <= scope.maxRange
                error: 'There\'s a range restriction on this field'
            })
