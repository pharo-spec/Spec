Class {
	#name : 'SpRadioButtonPresenterTest',
	#superclass : 'SpSmokeTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpRadioButtonPresenterTest >> classToTest [
	^  SpRadioButtonPresenter
]

{ #category : 'tests' }
SpRadioButtonPresenterTest >> testClickDoesNotToggleStateWhenRadioButtonIsDisabled [

	| otherRadioButton |
	otherRadioButton := self classToTest new.
	presenter associatedRadioButtons: { otherRadioButton }.
	otherRadioButton state: true.
	self deny: presenter state.

	presenter enabled: false.
	presenter click.
	self deny: presenter state.
	self assert: otherRadioButton state.

	presenter enabled: true.
	presenter click.
	self assert: presenter state.
	self deny: otherRadioButton state
]
