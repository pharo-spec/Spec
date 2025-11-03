Class {
	#name : 'SpSwitchPresenterTest',
	#superclass : 'SpSpecTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpSwitchPresenterTest >> classToTest [

	^ SpSwitchPresenter
]

{ #category : 'tests' }
SpSwitchPresenterTest >> testClickDoesNotToggleStateWhenSwitchIsDisabled [

	presenter state: false.

	presenter enabled: false.
	presenter click.
	self deny: presenter state.

	presenter enabled: true.
	presenter click.
	self assert: presenter state
]
