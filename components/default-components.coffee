angular.module 'builder.components', ['builder', 'validator.rules']

.config ['$builderProvider', ($builderProvider) ->

    # ----------------------------------------
    # static text field
    # ----------------------------------------
    $builderProvider.registerComponent 'textMessage',
        group: 'Basic'
        placeholder: 'Rich Content'
        label: 'Rich Content'
        template:
            """
            <div class="form-group text-center">
                <rich-text><strong>Text Message</strong></rich-text>                
            </div>
            <div class="hr-line-dashed"></div>
            """
        popoverTemplate:
            """
            <form>

                <div role="tabpanel">

                    <!-- Nav tabs -->
                    <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                        <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                        <li role="presentation" class="disabled"><a>Validations</a></li>
                        <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                            <div class="form-group">
                                <label class='control-label'>Placeholder</label>
                                <input type='text' ng-model="placeholder" class='form-control'/>
                            </div>
                            <div class="form-group">
                              <a class="btn btn-success btn-block" ng-click="openSummerNote()">Open Rich Text Editor</a>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                            <div class="form-group">
                                Hide this element if
                                <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                </select>
                                <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                </select>
                                <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                            </div>
                        </div>
                    </div>
                </div>

                <hr/>
                <div class='form-group'>
                    <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                    <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                    <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                </div>
            </form>
            """

    # ----------------------------------------
    # email field
    # ----------------------------------------
    $builderProvider.registerComponent 'emailInput',
        group: 'Basic'
        label: 'Email Input'
        description: 'description'
        requireConfirmation: no
        required: no
        readOnly: no
        template:
            """
            <div class="row">
                  <label class="col-sm-2 control-label" for="{{formName+index}}" ng-class="{'fb-required':required}">{{label}}
                  </label>
                    <div class="col-sm-10">
                        <input ng-if="!readOnly" type="email" ng-model="inputText" placeholder="Email" class="form-control m-b" id="{{formName+index}}" validator-required="{{required}}" validator-group="{{formName}}">
                        <input type="email" ng-if="requireConfirmation && !readOnly" ng-model="confirmEmail" placeholder="Confirm email" class="form-control m-b" id="confirmEmail">
                        <input ng-if="readOnly" type="email" ng-model="inputText" placeholder="Email" class="form-control m-b" id="{{formName+index}}" validator-required="{{required}}" validator-group="{{formName}}" disabled>
                        <input type="email" ng-if="requireConfirmation && readOnly" ng-model="confirmEmail" placeholder="Confirm email" class="form-control m-b" id="confirmEmail" disabled>
                    </div>
                <div class="col-sm-12">
                  <small class='help-block text-muted custom-small'>{{description}}</small>
                </div>
            </div>
            <div class="hr-line-dashed"></div>
            """
        popoverTemplate:
            """
            <form>

                <div role="tabpanel">

                    <!-- Nav tabs -->
                    <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                        <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                        <li role="presentation"><a href="{{'#validations' + date + index}}" aria-controls="{{'validations' + date + index}}" role="tab" data-toggle="tab">Validations</a></li>
                        <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                            <div class="form-group">
                                <label class='control-label'>Label</label>
                                <input type='text' ng-model="label" validator="[required]" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Description</label>
                                <input type='text' ng-model="description" class='form-control'/>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="readOnly" />
                                    Read Only</label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="required" />
                                    Required</label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="requireConfirmation" />
                                    Require Email Confirmation</label>
                            </div>
                            <div class="form-group" ng-if="validationOptions.length > 0">
                                <label class='control-label'>Validation</label>
                                <select ng-model="$parent.validation" class='form-control' ng-options="option.rule as option.label for option in validationOptions"></select>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                            <div class="form-group">
                                Hide this element if
                                <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                </select>
                                <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                </select>
                                <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                            </div>
                        </div>
                </div>

                <hr/>
                <div class='form-group'>
                    <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                    <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                    <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                </div>
            </form>
            """


    # ----------------------------------------
    # date picker
    # ----------------------------------------
    $builderProvider.registerComponent 'datePicker',
        group: 'Basic'
        label: 'Date Picker'
        description: 'description'
        required: no
        disableWeekends: no
        readOnly: no
        # minDate: '2000-01-01'
        # maxDate: '2100-01-01'
        template:
            """
            <div class="row">
                  <label class="col-sm-2 control-label" for="{{formName+index}}" ng-class="{'fb-required':required}">{{label}}</label>
                  </label>
                  <div class="col-sm-10">
                    <ui-date weekends="{{disableWeekends}}"></ui-date>
                  </div>
                <div class="col-sm-12">
                  <small class="help-block text-muted custom-small">{{description}}</small>
                </div>
            </div>
            <div class="hr-line-dashed"></div>
            """
        popoverTemplate:
            """
            <form>

                <div role="tabpanel">

                    <!-- Nav tabs -->
                    <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                        <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                        <li role="presentation"><a href="{{'#validations' + date + index}}" aria-controls="{{'validations' + date + index}}" role="tab" data-toggle="tab">Validations</a></li>
                        <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                            <div class="form-group">
                                <label class='control-label'>Label</label>
                                <input type='text' ng-model="label" validator="[required]" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Description</label>
                                <input type='text' ng-model="description" class='form-control'/>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="readOnly" />
                                    Read Only</label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="required" />
                                    Required</label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="disableWeekends" />
                                    Disable Weekends</label>
                            </div>
                            <div class="form-group" ng-if="validationOptions.length > 0">
                                <label class='control-label'>Validation</label>
                                <select ng-model="$parent.validation" class='form-control' ng-options="option.rule as option.label for option in validationOptions"></select>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-sm-3">
                                        Date is in next
                                    </div>
                                    <div class="col-sm-7">
                                        <select class="form-control" ng-model="nextXDays" ng-options="value for value in [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]"></select>
                                    </div>
                                    <div class="col-sm-2">
                                        days
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                            <div class="form-group">
                                Hide this element if
                                <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                </select>
                                <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                </select>
                                <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                            </div>
                        </div>
                    </div>
                </div>

                <hr/>
                <div class='form-group'>
                    <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                    <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                    <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                </div>
            </form>
            """

    # ----------------------------------------
    # text input
    # ----------------------------------------
    $builderProvider.registerComponent 'textInput',
        group: 'Basic'
        label: 'Text Input'
        description: 'description'
        placeholder: 'placeholder'
        readOnly: no
        minLength: 0
        maxLength: 999
        minRange: 0
        maxRange: 99999
        required: no
        validationOptions: [
            {label: 'None', rule: '/.*/'}
            {label: 'Text', rule: '[text]'}
            {label: 'Number', rule: '[numberRange]'}
        ]
        template:
            """
            <div class="row">
                <label class="col-sm-2 control-label" for="{{formName+index}}" ng-class="{'fb-required':required}">{{label}}</label>
                </label>
                <div class="col-sm-10">
                    <input type="text" ng-if="!readOnly" ng-model="inputText" validator-required="{{required}}" validator-group="{{formName}}" id="{{formName+index}}" class="form-control m-b" placeholder="{{placeholder}}"/>
                    <input type="text" ng-if="readOnly" ng-model="inputText" validator-required="{{required}}" validator-group="{{formName}}" id="{{formName+index}}" class="form-control m-b" placeholder="{{placeholder}}" disabled/>
                </div>
              <div class="col-sm-12">
                <small class="help-block text-muted custom-small">{{description}}</small>
              </div>
            </div>
            <div class="hr-line-dashed"></div>
            """
        popoverTemplate:
            """
            <form>

                <div role="tabpanel">

                    <!-- Nav tabs -->
                    <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                        <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                        <li role="presentation"><a href="{{'#validations' + date + index}}" aria-controls="{{'validations' + date + index}}" role="tab" data-toggle="tab">Validations</a></li>
                        <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                            <div class="form-group">
                                <label class='control-label'>Label</label>
                                <input type='text' ng-model="label" validator="[required]" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Description</label>
                                <input type='text' ng-model="description" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Placeholder</label>
                                <input type='text' ng-model="placeholder" class='form-control'/>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="readOnly" />
                                    Read Only</label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="required" />
                                    Required</label>
                            </div>
                            <div class="form-group" ng-if="validationOptions.length > 0">
                                <label class='control-label'>Validation</label>
                                <select ng-model="$parent.validation" class='form-control' ng-options="option.rule as option.label for option in validationOptions"></select>
                            </div>
                            <div class="row" ng-show="validation==='[text]'">
                                <div class="form-group col-sm-6">
                                    <input type="text" class="form-control" ng-model="minLength" placeholder="Min Length">
                                </div>
                                <div class="form-group col-sm-6">
                                    <input type="text" class="form-control" ng-model="maxLength" placeholder="Max Length">
                                </div>
                            </div>
                            <div class="row" ng-show="validation==='[numberRange]'">
                                <div class="form-group col-sm-6">
                                    <input type="text" class="form-control" ng-model="minRange" placeholder="Min">
                                </div>
                                <div class="form-group col-sm-6">
                                    <input type="text" class="form-control" ng-model="maxRange" placeholder="Max">
                                </div>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                            <div class="form-group">
                                Hide this element if
                                <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                </select>
                                <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                </select>
                                <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                            </div>
                        </div>
                    </div>
                </div>

                <hr/>
                <div class='form-group'>
                    <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                    <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                    <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                </div>
            </form>
            """

    # ----------------------------------------
    # Text area
    # ----------------------------------------
    $builderProvider.registerComponent 'textArea',
        group: 'Basic'
        label: 'Text Area'
        description: 'description'
        placeholder: 'placeholder'
        required: no
        readOnly: no
        template:
            """
            <div class="row">
                <label class="col-sm-2 control-label" for="{{formName+index}}" ng-class="{'fb-required':required}">{{label}}</label>
                </label>
                <div class="col-sm-10">
                    <textarea type="text" ng-if="!readOnly" ng-model="inputText" validator-required="{{required}}" validator-group="{{formName}}" id="{{formName+index}}" class="form-control m-b" rows='6' placeholder="{{placeholder}}"/>
                    <textarea type="text" ng-if="readOnly" ng-model="inputText" validator-required="{{required}}" validator-group="{{formName}}" id="{{formName+index}}" class="form-control m-b" rows='6' placeholder="{{placeholder}}" disabled/>
                </div>
                <div class="col-sm-12">
                  <small class="help-block text-muted custom-small">{{description}}</small>
                </div>
            </div>
            <div class="hr-line-dashed"></div>
            """
        popoverTemplate:
            """
            <form>

                <div role="tabpanel">

                    <!-- Nav tabs -->
                    <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                        <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                        <li role="presentation"><a href="{{'#validations' + date + index}}" aria-controls="{{'validations' + date + index}}" role="tab" data-toggle="tab">Validations</a></li>
                        <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                            <div class="form-group">
                                <label class='control-label'>Label</label>
                                <input type='text' ng-model="label" validator="[required]" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Description</label>
                                <input type='text' ng-model="description" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Placeholder</label>
                                <input type='text' ng-model="placeholder" class='form-control'/>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="readOnly" />
                                    Read Only</label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="required" />
                                    Required</label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                            <div class="form-group">
                                Hide this element if
                                <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                </select>
                                <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                </select>
                                <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                            </div>
                        </div>
                    </div>
                </div>

                <hr/>
                <div class='form-group'>
                    <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                    <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                    <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                </div>
            </form>
            """

    # ----------------------------------------
    # checkbox
    # ----------------------------------------
    $builderProvider.registerComponent 'checkbox',
        group: 'Choice'
        label: 'Checkbox'
        description: 'description'
        placeholder: 'placeholder'
        required: no
        options: ['value one', 'value two']
        arrayToText: yes
        readOnly: no
        template:
            """
            <div class="row">

                <label for="{{formName+index}}" class="col-sm-2 control-label" ng-class="{'fb-required':required}">{{label}}</label>
                <div class="col-sm-10">
                    <input type='hidden' ng-model="inputText" validator-required="{{required}}" validator-group="{{formName}}" id="{{formName+index}}"/>
                    <div class='checkbox' ng-repeat="item in options track by $index">
                        <input ng-if="!readOnly" type='checkbox' ng-model="$parent.inputArray[$index]" value='item'/>
                        <input ng-if="readOnly" type='checkbox' ng-model="$parent.inputArray[$index]" value='item' disabled/>
                            {{item}}
                    </div>
                    <p class='help-block'>{{description}}</p>
                </div>
            </div>
            <div class="hr-line-dashed"></div>
            """
        popoverTemplate:
            """
            <form>

                <div role="tabpanel">

                    <!-- Nav tabs -->
                    <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                        <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                        <li role="presentation"><a href="{{'#validations' + date + index}}" aria-controls="{{'validations' + date + index}}" role="tab" data-toggle="tab">Validations</a></li>
                        <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                            <div class="form-group">
                                <label class='control-label'>Label</label>
                                <input type='text' ng-model="label" validator="[required]" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Description</label>
                                <input type='text' ng-model="description" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Options</label>
                                <textarea class="form-control" rows="3" ng-model="optionsText"/>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="readOnly" />
                                    Read Only</label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="required" />
                                    Required
                                </label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                            <div class="form-group">
                                Hide this element if
                                <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                </select>
                                <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                </select>
                                <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                            </div>
                        </div>
                    </div>
                </div>

                <hr/>
                <div class='form-group'>
                    <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                    <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                    <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                </div>
            </form>
            """

    # ----------------------------------------
    # radio
    # ----------------------------------------
    $builderProvider.registerComponent 'radio',
        group: 'Choice'
        label: 'Radio'
        description: 'description'
        placeholder: 'placeholder'
        required: no
        readOnly: no
        options: ['value one', 'value two']
        template:
            """
            <div class="row">
                <label for="{{formName+index}}" class="col-sm-2 control-label" ng-class="{'fb-required':required}">{{label}}</label>
                <div class="col-sm-10">
                    <div class='radio' ng-repeat="item in options track by $index">
                        <label>
                        <input ng-if="!readOnly" name='{{formName+index}}' ng-model="$parent.inputText" validator-group="{{formName}}" value='{{item}}' id="{{formName+index}}" type='radio'/>
                        <input ng-if="readOnly" name='{{formName+index}}' ng-model="$parent.inputText" validator-group="{{formName}}" value='{{item}}' id="{{formName+index}}" type='radio' disabled/>
                            {{item}}
                        </label>
                    </div>
                    <p class='help-block'>{{description}}</p>
                </div>
            </div>
            <div class="hr-line-dashed"></div>
            """
        popoverTemplate:
            """
            <form>

                <div role="tabpanel">

                    <!-- Nav tabs -->
                    <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                        <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                        <li role="presentation" class="disabled"><a>Validations</a></li>
                        <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                            <div class="form-group">
                                <label class='control-label'>Label</label>
                                <input type='text' ng-model="label" validator="[required]" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Description</label>
                                <input type='text' ng-model="description" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Options</label>
                                <textarea class="form-control" rows="3" ng-model="optionsText"/>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="readOnly" />
                                    Read Only</label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="required" />
                                    Required
                                </label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                            <div class="form-group">
                                Hide this element if
                                <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                </select>
                                <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                </select>
                                <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                            </div>
                        </div>
                    </div>
                </div>

                <hr/>
                <div class='form-group'>
                    <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                    <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                    <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                </div>
            </form>
            """

    # ----------------------------------------
    # select
    # ----------------------------------------
    $builderProvider.registerComponent 'select',
        group: 'Choice'
        label: 'Select'
        description: 'description'
        placeholder: 'placeholder'
        multiple: no
        required: no
        readOnly: no
        options: ['value one', 'value two']
        # multiple: no
        # validationOptions: [
        #     {label: 'single select', rule: '/.*/'}
        #     {label: 'multiple select', rule: ['multiselect']}
        # ]
        template:
            """
            <div class="row">
                    <label class="col-sm-2 control-label" for="{{formName+index}}" ng-class="{'fb-required':required}">{{label}}</label>
                </label>

                <div class="col-sm-10 dropdown">
                    <select ng-if="!multiple && !readOnly" ng-options="value for value in options" id="{{formName+index}}" class="form-control m-b"
                        ng-model="inputText" ng-init="inputText = options[0]"/>
                    <select ng-if="!multiple && readOnly" ng-options="value for value in options" id="{{formName+index}}" class="form-control m-b"
                        ng-model="inputText" ng-init="inputText = options[0]" disabled/>
                    <select ng-if="multiple && !readOnly" ng-options="value for value in options" id="{{formName+index}}" class="form-control m-b"
                        ng-model="inputText" multiple ng-init="inputText = options[0]"/>
                    <select ng-if="multiple && readOnly" ng-options="value for value in options" id="{{formName+index}}" class="form-control m-b"
                        ng-model="inputText" multiple ng-init="inputText = options[0]" disabled/>
                </div>
                <div class="col-sm-12">
                  <small class="help-block text-muted custom-small">{{description}}</small>
                </div>
            </div>
            <div class="hr-line-dashed"></div>
            """
        popoverTemplate:
            """
            <form>

                <div role="tabpanel">

                    <!-- Nav tabs -->
                    <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                        <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                        <li role="presentation"><a href="{{'#validations' + date + index}}" aria-controls="{{'validations' + date + index}}" role="tab" data-toggle="tab">Validations</a></li>
                        <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                            <div class="form-group">
                                <label class='control-label'>Label</label>
                                <input type='text' ng-model="label" validator="[required]" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Description</label>
                                <input type='text' ng-model="description" class='form-control'/>
                            </div>
                            <div class="form-group">
                                <label class='control-label'>Options</label>
                                <textarea class="form-control" rows="3" ng-model="optionsText"/>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="readOnly" />
                                    Read Only</label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="required" />
                                    Required
                                </label>
                            </div>
                            <div class="form-group" ng-if="validationOptions.length > 0">
                                <label class='control-label'>Validation</label>
                                <select ng-model="$parent.validation" class='form-control' ng-options="option.rule as option.label for option in validationOptions"></select>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type='checkbox' ng-model="multiple" />
                                    Multiple Select</label>
                            </div>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                            <div class="form-group">
                                Hide this element if
                                <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                </select>
                                <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                </select>
                                <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                            </div>
                        </div>
                    </div>
                </div>

                <hr/>
                <div class='form-group'>
                    <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                    <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                    <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                </div>
            </form>
            """

        # ----------------------------------------
        # Address field
        # ----------------------------------------
        $builderProvider.registerComponent 'addressField',
            group: 'Advanced'
            label: 'Address Field'
            description: 'description'
            required: no
            readOnly: no
            options: []
            template:
                """
                <div class="row">
                        <label class="col-sm-2 control-label" for="{{formName+index}}" ng-class="{'fb-required':required}">{{label}}</label>
                    </label>

                    <div ng-if="!readOnly" class="col-sm-10">
                        <input type="text" ng-model="$parent.inputText.StreetName" class="form-control m-b" placeholder="Street Name"/>
                        <input type="text" ng-model="$parent.inputText.Number" class="form-control m-b" placeholder="Number"/>
                        <input type="text" ng-model="$parent.inputText.Letter" class="form-control m-b" placeholder="Letter"/>
                        <input type="text" ng-model="$parent.inputText.Floor" class="form-control m-b" placeholder="Floor"/>
                        <input type="text" ng-model="$parent.inputText.PlaceName" class="form-control m-b" placeholder="Place Name"/>
                        <input type="text" ng-model="$parent.inputText.PostCode" class="form-control m-b" placeholder="Post Code"/>
                        <input type="text" ng-model="$parent.inputText.City" id="{{formName+index}}" class="form-control m-b" placeholder="City" validator-required={{required}} validator-group={{formName}}/>
                    </div>
                    <div ng-if="readOnly" class="col-sm-10">
                        <input type="text" ng-model="$parent.inputText.StreetName" class="form-control m-b" placeholder="Street Name" disabled/>
                        <input type="text" ng-model="$parent.inputText.Number" class="form-control m-b" placeholder="Number" disabled/>
                        <input type="text" ng-model="$parent.inputText.Letter" class="form-control m-b" placeholder="Letter" disabled/>
                        <input type="text" ng-model="$parent.inputText.Floor" class="form-control m-b" placeholder="Floor" disabled/>
                        <input type="text" ng-model="$parent.inputText.PlaceName" class="form-control m-b" placeholder="Place Name" disabled/>
                        <input type="text" ng-model="$parent.inputText.PostCode" class="form-control m-b" placeholder="Post Code" disabled/>
                        <input type="text" ng-model="$parent.inputText.City" id="{{formName+index}}" class="form-control m-b" placeholder="City" validator-required={{required}} validator-group={{formName}} disabled/>
                    </div>
                    <div class="col-sm-12">
                        <small class="help-block text-muted custom-small">{{description}}</small>
                    </div>
                </div>
                <div class="hr-line-dashed"></div>
                """
            popoverTemplate:
                """
                <form>

                    <div role="tabpanel">

                        <!-- Nav tabs -->
                        <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                            <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                            <li role="presentation"><a href="{{'#validations' + date + index}}" aria-controls="{{'validations' + date + index}}" role="tab" data-toggle="tab">Validations</a></li>
                            <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                                <div class="form-group">
                                    <label class='control-label'>Label</label>
                                    <input type='text' ng-model="label" validator="[required]" class='form-control'/>
                                </div>
                                <div class="form-group">
                                    <label class='control-label'>Description</label>
                                    <input type='text' ng-model="description" class='form-control'/>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type='checkbox' ng-model="readOnly" />
                                        Read Only</label>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                                <div class="checkbox">
                                    <label>
                                        <input type='checkbox' ng-model="required" />
                                        Required</label>
                                </div>
                                <div class="form-group" ng-if="validationOptions.length > 0">
                                    <label class='control-label'>Validation</label>
                                    <select ng-model="$parent.validation" class='form-control' ng-options="option.rule as option.label for option in validationOptions"></select>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                                <div class="form-group">
                                    Hide this element if
                                    <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                    </select>
                                    <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                    </select>
                                    <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                                </div>
                            </div>
                        </div>

                    </div>

                    <hr/>
                    <div class='form-group'>
                        <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                        <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                        <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                    </div>
                </form>
                """


            # ----------------------------------------
            # upload photo button
            # ----------------------------------------
            $builderProvider.registerComponent 'uploadPhoto',
                group: 'Advanced'
                label: 'Upload Photo'
                description: 'description'
                required: no
                readOnly: no
                template:
                    """
                    <div class="row">
                            <label class="col-sm-2 control-label" for="{{formName+index}}" ng-class="{'fb-required':required}">{{label}}</label>
                        </label>
                        <div class="col-sm-10">
                            <input ng-if="!readOnly" type="file" class="m-b" accept="image/*" capture="camera" id="{{formName+index}}">
                            <input ng-if="readOnly" type="file" class="m-b" accept="image/*" capture="camera" id="{{formName+index}}" disabled>
                        </div>
                        <div class="col-sm-12">
                            <small class="help-block text-muted custom-small">{{description}}</small>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    """
                popoverTemplate:
                    """
                    <form>

                        <div role="tabpanel">

                            <!-- Nav tabs -->
                            <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                                <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                                <li role="presentation"><a href="{{'#validations' + date + index}}" aria-controls="{{'validations' + date + index}}" role="tab" data-toggle="tab">Validations</a></li>
                                <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                                    <div class="form-group">
                                        <label class='control-label'>Label</label>
                                        <input type='text' ng-model="label" validator="[required]" class='form-control'/>
                                    </div>
                                    <div class="form-group">
                                        <label class='control-label'>Description</label>
                                        <input type='text' ng-model="description" class='form-control'/>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type='checkbox' ng-model="readOnly" />
                                            Read Only</label>
                                    </div>
                                </div>
                                <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                                    <div class="checkbox">
                                        <label>
                                            <input type='checkbox' ng-model="required" />
                                            Required</label>
                                    </div>
                                    <div class="form-group" ng-if="validationOptions.length > 0">
                                        <label class='control-label'>Validation</label>
                                        <select ng-model="$parent.validation" class='form-control' ng-options="option.rule as option.label for option in validationOptions"></select>
                                    </div>
                                </div>
                                <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                                    <div class="form-group">
                                        Hide this element if
                                        <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                        </select>
                                        <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                        </select>
                                        <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <hr/>
                        <div class='form-group'>
                            <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                            <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                            <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                        </div>
                    </form>
                    """

            # ----------------------------------------
            # signature pad
            # ----------------------------------------
            $builderProvider.registerComponent 'signaturePad',
                group: 'Advanced'
                label: 'Signature Pad'
                decription: 'description'
                required: no
                readOnly: no
                template:
                    """
                    <div class="row">
                            <label class="col-sm-2 control-label" for="{{formName+index}}" ng-class="{'fb-required':required}">{{label}}</label>
                        </label>
                        <div class="col-sm-10">
                            <div class="m-b">
                                <signature-pad></signature-pad>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <small class="help-block text-muted custom-small"></small>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    """
                popoverTemplate:
                    """
                    <form>

                        <div role="tabpanel">

                            <!-- Nav tabs -->
                            <ul class="nav nav-justified nav-tabs" role="tablist" style="margin-left:-10px">
                                <li role="presentation" class="active"><a href="{{'#properties' + date + index}}" aria-controls="{{'properties' + date + index}}" role="tab" data-toggle="tab">Properties</a></li>
                                <li role="presentation"><a href="{{'#validations' + date + index}}" aria-controls="{{'validations' + date + index}}" role="tab" data-toggle="tab">Validations</a></li>
                                <li role="presentation"><a href="{{'#logic' + date + index}}" aria-controls="{{'logic' + date + index}}" role="tab" data-toggle="tab">Logic</a></li>
                            </ul>

                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane active" id="{{'properties' + date + index}}">
                                    <div class="form-group">
                                        <label class='control-label'>Label</label>
                                        <input type='text' ng-model="label" validator="[required]" class='form-control'/>
                                    </div>
                                    <div class="form-group">
                                        <label class='control-label'>Description</label>
                                        <input type='text' ng-model="description" class='form-control'/>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type='checkbox' ng-model="readOnly" />
                                            Read Only</label>
                                    </div>
                                </div>
                                <div role="tabpanel" class="tab-pane" id="{{'validations' + date + index}}">
                                    <div class="checkbox">
                                        <label>
                                            <input type='checkbox' ng-model="required"/>
                                            Required</label>
                                    </div>
                                </div>
                                <div role="tabpanel" class="tab-pane" id="{{'logic' + date + index}}">
                                    <div class="form-group">
                                        Hide this element if
                                        <select class="form-control" ng-model="formObject.logic.component" ng-options="field.label for field in fields">
                                        </select>
                                        <select class="form-control" ng-model="formObject.logic.comparator" ng-options="comparator for comparator in comparatorChoices">
                                        </select>
                                        <input type="text" ng-model="formObject.logic.value" class="form-control" placeholder="Value">
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group" ng-if="validationOptions.length > 0">
                            <label class='control-label'>Validation</label>
                            <select ng-model="$parent.validation" class='form-control' ng-options="option.rule as option.label for option in validationOptions"></select>
                        </div>

                        <hr/>
                        <div class='form-group'>
                            <input type='submit' ng-click="popover.save($event)" class='btn btn-primary' value='Apply'/>
                            <input type='button' ng-click="popover.cancel($event)" class='btn btn-default' value='Cancel'/>
                            <input type='button' ng-click="popover.remove($event)" class='btn btn-danger' value='Delete'/>
                        </div>
                    </form>
                    """
]
