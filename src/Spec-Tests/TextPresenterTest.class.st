Class {
	#name : #TextPresenterTest,
	#superclass : #SpecSmokeTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
TextPresenterTest >> classToTest [
	^ TextPresenter
]

{ #category : #running }
TextPresenterTest >> initializationText [
	presenter text: 'Text for tests.'
]

{ #category : #tests }
TextPresenterTest >> testSelectAll [
	self initializationText.
	self openInstance.
	presenter selectAll.
	self assert: presenter getSelection equals: (1 to: 15).
	presenter clearSelection.
	self assert: presenter getSelection isEmpty
]

{ #category : #tests }
TextPresenterTest >> testSelectionChangedAnnouncement [
	|selectionHolder tag|
	self initializationText.
	selectionHolder := (self classToTest slotNamed: #selection) read: presenter.
	selectionHolder whenChangedDo: [ tag := #tag ].
	self assert: tag isNil.	
	presenter setSelectionInterval: (1 to: 15).
	self assert: tag equals: #tag
]
