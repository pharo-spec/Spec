Class {
	#name : #SpOptionListPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'dialog'
	],
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #'instance creation' }
SpOptionListPresenterTest >> newOptionsPresenterWithOneOption [
	| optionPresenterClass optionPresenter presenter |
	
	optionPresenterClass := SpOptionPresenter newAnonymousSubclass.
	optionPresenterClass compile: 'optionIcon ^ self iconNamed: #add'.
	optionPresenterClass compile: 'optionTitle ^ #foo'.
	optionPresenterClass compile: 'initialize super initialize. self layout: SpBoxLayout newTopToBottom.'.
	optionPresenter := optionPresenterClass new.
	
	presenter := SpOptionListPresenter new.
	presenter addOption: optionPresenter.
	
	^ presenter
]

{ #category : #'instance creation' }
SpOptionListPresenterTest >> newOptionsPresenterWithTwoOptions [
	| optionPresenterClass optionPresenter presenter |
	
	presenter := self newOptionsPresenterWithOneOption.
	
	optionPresenterClass := SpOptionPresenter newAnonymousSubclass.
	optionPresenterClass := optionPresenterClass addSlot: #input => InstanceVariableSlot.
	optionPresenterClass := optionPresenterClass addSlot: #label => InstanceVariableSlot.
	optionPresenterClass compile: 'optionIcon ^ self iconNamed: #back'.
	optionPresenterClass compile: 'optionTitle ^ #bar'.
	optionPresenterClass compile: 'initialize 
		super initialize. 
		label := self newLabel label: ''aLabel''; yourself.
		input := (self instantiate: SpTextInputFieldWithValidationPresenter) beRequired; yourself.
		self layout: (SpBoxLayout newTopToBottom add: label; add: input; yourself).
		'.
	optionPresenter := optionPresenterClass new.	
	presenter addOption: optionPresenter.
		
	^ presenter
]

{ #category : #running }
SpOptionListPresenterTest >> tearDown [ 
	dialog ifNotNil: [ :d | d delete].
	super tearDown .
]

{ #category : #tests }
SpOptionListPresenterTest >> testContentPanelIsEmptyWhenNoSelection [
	| presenterClass presenter |
	presenterClass := SpOptionListPresenter newAnonymousSubclass.
	presenterClass compile: 'allOptions ^ #()'.
	presenter := presenterClass new
		build;
		yourself.
	
	self assertEmpty: presenter contentLayout.
]

{ #category : #tests }
SpOptionListPresenterTest >> testContentPanelIsUpdatedWhenSelectionChanges [
	| presenter optionPanel |
	presenter := SpOptionListExample new.
	presenter selectIndex: 2.
	
	self 
		assert: presenter contentLayout presenters size
		equals: 1.
	
	optionPanel := presenter contentLayout presenters first.
	self 
		assert: optionPanel class
		equals: presenter allOptions second class.
]

{ #category : #tests }
SpOptionListPresenterTest >> testDoAcceptIsExecutedWhenAcceptingDialog [
	| presenter optionPresenter |
	
	presenter := self newOptionsPresenterWithOneOption.
	optionPresenter := presenter allOptions first.
	optionPresenter class compile: 'doAccept self class propertyAt: #executed put: true'.
	dialog := presenter openDialog.
	
	dialog triggerOkAction.
	
	self assert: (optionPresenter class propertyAt: #executed).
	
]

{ #category : #tests }
SpOptionListPresenterTest >> testDoAcceptIsNotExecutedWhenCancelingDialog [
	| presenter optionPresenter |
	
	presenter := self newOptionsPresenterWithOneOption.
	optionPresenter := presenter allOptions first.
	optionPresenter class compile: 'doAccept self class propertyAt: #executed put: true'.
	dialog := presenter openDialog.

	dialog triggerCancelAction.
	
	self assert: (optionPresenter class propertyAt: #executed) equals: nil.
	
]

{ #category : #tests }
SpOptionListPresenterTest >> testFirstOptionIsSelectedWhenOpening [
	| presenter |
	presenter := SpOptionListExample new.
	presenter build.

	self 
		assert: presenter selectedOption
		equals: (presenter optionAt: 1)
]

{ #category : #tests }
SpOptionListPresenterTest >> testOptionListItemHasIcon [
	| presenter optionIndex iconColumn icon |
	presenter := SpOptionListExample new.

	optionIndex := 1.
	iconColumn := 1.
	icon := presenter optionsPresenter valueAtColumn: iconColumn row: optionIndex.

	self 
		assert: icon
		equals: presenter allOptions first optionIcon
]

{ #category : #tests }
SpOptionListPresenterTest >> testOptionListItemHasTitle [
	| presenter optionIndex titleColumn icon |
	presenter := SpOptionListExample new.

	optionIndex := 1.
	titleColumn := 2.
	icon := presenter optionsPresenter valueAtColumn: titleColumn row: optionIndex.

	self 
		assert: icon
		equals: presenter allOptions first optionTitle
]

{ #category : #'tests - validation' }
SpOptionListPresenterTest >> testValidationIsCalledOnSelectedOptionPresenter [
	| presenter optionPresenter |
	
	presenter := self newOptionsPresenterWithTwoOptions.
	optionPresenter := presenter allOptions second.
	optionPresenter class compile: 'validate self class propertyAt: #validated put: true'.
	dialog := presenter openDialog.
	presenter selectOptionAt: 2.

	dialog triggerOkAction.
	
	self assert: (optionPresenter class propertyAt: #validated) equals: true.
]

{ #category : #'tests - validation' }
SpOptionListPresenterTest >> testValidationIsNotCalledOnNotSelectedOptionPresenters [
	| presenter optionPresenter |
	
	presenter := self newOptionsPresenterWithTwoOptions.
	optionPresenter := presenter allOptions first.
	optionPresenter class compile: 'validate self class propertyAt: #validated put: true'.
	dialog := presenter openDialog.
	presenter selectOptionAt: 2.

	dialog triggerOkAction.
	
	self assert: (optionPresenter class propertyAt: #validated) equals: nil.
]
