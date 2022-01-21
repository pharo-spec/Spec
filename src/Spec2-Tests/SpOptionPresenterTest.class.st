Class {
	#name : #SpOptionPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'optionPresenterClass'
	],
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #running }
SpOptionPresenterTest >> setUp [
	super setUp.
	
	optionPresenterClass := SpOptionPresenter newAnonymousSubclass.
	optionPresenterClass := optionPresenterClass addSlot: #input => InstanceVariableSlot.
	optionPresenterClass := optionPresenterClass addSlot: #label => InstanceVariableSlot.
	optionPresenterClass compile: 'optionIcon ^ self iconNamed: #back'.
	optionPresenterClass compile: 'optionTitle ^ #bar'.
	optionPresenterClass compile: 'input ^ input'.

]

{ #category : #tests }
SpOptionPresenterTest >> testValidationFailsWhenValidationsNotSatisfied [
	| optionPresenter validationReport |
	
	optionPresenterClass compile: 'initialize 
		super initialize. 
		label := self newLabel label: ''aLabel''; yourself.
		input := (self instantiate: SpTextInputFieldWithValidationPresenter) beRequired; yourself.
		self layout: (SpBoxLayout newTopToBottom add: label; add: input; yourself).
		'.
	optionPresenter := optionPresenterClass new.	

	validationReport := optionPresenter validate.
	
	self assert: validationReport hasErrors.
	self assert: validationReport errors size equals: 1.
	self assert: validationReport errors first target equals: optionPresenter input.
]

{ #category : #tests }
SpOptionPresenterTest >> testValidationSucceedsWhenValidationsSatisfied [
	| optionPresenter validationReport |
	
	optionPresenterClass compile: 'initialize 
		super initialize. 
		label := self newLabel label: ''aLabel''; yourself.
		input := (self instantiate: SpTextInputFieldWithValidationPresenter) beRequired; text: ''bla''; yourself.
		self layout: (SpBoxLayout newTopToBottom add: label; add: input; yourself).
		'.
	optionPresenter := optionPresenterClass new.	

	validationReport := optionPresenter validate.
	
	self deny: validationReport hasErrors 
]
