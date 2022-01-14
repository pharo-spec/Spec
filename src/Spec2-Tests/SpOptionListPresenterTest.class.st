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
	optionPresenterClass compile: 'optionTitle ^ #bar'.
	optionPresenterClass compile: 'initialize super initialize. self layout: SpBoxLayout newTopToBottom.'.
	optionPresenter := optionPresenterClass new.
	
	presenter := SpOptionListPresenter new.
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
		buildWithSpec;
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
	dialog := presenter openDialogWithSpec.
	
	dialog triggerOkAction.
	
	self assert: (optionPresenter class propertyAt: #executed).
	
]

{ #category : #tests }
SpOptionListPresenterTest >> testDoAcceptIsNotActivatedIfValidationFails [
	| presenter optionPresenter |
	
	presenter := self newOptionsPresenterWithOneOption.
	optionPresenter := presenter allOptions first.
	optionPresenter class compile: 'doAccept self class propertyAt: #executed put: true'.
	dialog := presenter openDialogWithSpec.

	dialog triggerCancelAction.
	
	self deny: (dialog isButtonEnabled: 'Ok').
	self assert: (optionPresenter class propertyAt: #executed) equals: nil.
]

{ #category : #tests }
SpOptionListPresenterTest >> testDoAcceptIsNotExecutedWhenCancelingDialog [
	| presenter optionPresenter |
	
	presenter := self newOptionsPresenterWithOneOption.
	optionPresenter := presenter allOptions first.
	optionPresenter class compile: 'doAccept self class propertyAt: #executed put: true'.
	dialog := presenter openDialogWithSpec.

	dialog triggerCancelAction.
	
	self assert: (optionPresenter class propertyAt: #executed) equals: nil.
	
]

{ #category : #tests }
SpOptionListPresenterTest >> testFirstOptionIsSelectedWhenOpening [
	| presenter |
	presenter := SpOptionListExample new.
	presenter buildWithSpec.

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
