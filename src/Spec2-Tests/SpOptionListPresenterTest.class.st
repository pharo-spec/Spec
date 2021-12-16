Class {
	#name : #SpOptionListPresenterTest,
	#superclass : #TestCase,
	#category : #'Spec2-Tests-Core-Widgets'
}

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
SpOptionListPresenterTest >> testOptionListItemHasIcon [
	| presenter optionIndex iconColumn icon |
	presenter := SpOptionListExample new.

	optionIndex := 1.
	iconColumn := 1.
	icon := presenter options valueAtColumn: iconColumn row: optionIndex.

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
	icon := presenter options valueAtColumn: titleColumn row: optionIndex.

	self 
		assert: icon
		equals: presenter allOptions first optionTitle
]
