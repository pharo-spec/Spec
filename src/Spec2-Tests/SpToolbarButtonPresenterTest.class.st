Class {
	#name : 'SpToolbarButtonPresenterTest',
	#superclass : 'SpAbstractButtonPresenterTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpToolbarButtonPresenterTest >> classToTest [

	^ SpToolbarButtonPresenter
]

{ #category : 'tests' }
SpToolbarButtonPresenterTest >> testClickDoesNotExecuteActionWhenButtonIsDisabled [

	| actionExecuted |
	actionExecuted := false.

	presenter action: [ actionExecuted := true ].
	self openInstance.
	self deny: actionExecuted.

	presenter enabled: false.
	presenter click.
	self deny: actionExecuted.

	presenter enabled: true.
	presenter click.
	self assert: actionExecuted
]
