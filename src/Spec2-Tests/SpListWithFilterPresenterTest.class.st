"
A SpListWithFilterPresenterTest is a test class for testing the behavior of SpListWithFilterPresenter
"
Class {
	#name : #SpListWithFilterPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'listWithFilter'
	],
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #running }
SpListWithFilterPresenterTest >> setUp [

	super setUp.

	listWithFilter := SpListWithFilterPresenter new
]

{ #category : #test }
SpListWithFilterPresenterTest >> testFilterListItems [

	| listItems |
	listItems := { 
		             OrderedCollection.
		             Array.
		             SequenceableCollection.
		             Set.
		             Dictionary }.
	listWithFilter items: listItems.
	listWithFilter filterListItems: 'collection'.
	self assertCollection: listWithFilter items hasSameElements: { 
			OrderedCollection.
			SequenceableCollection }.
	listWithFilter filterListItems: 'xyz'.
	self assertEmpty: listWithFilter items.
	listWithFilter filterListItems: 'Array'.
	self
		assertCollection: listWithFilter items
		hasSameElements: { Array }.
	listWithFilter filterListItems: ''.
	self
		assertCollection: listWithFilter items
		hasSameElements: listItems
]

{ #category : #test }
SpListWithFilterPresenterTest >> testFilterListItemsWithDifferentDisplay [

	| listItems |
	listItems := { OrderedCollection.
		             Array.
		             SequenceableCollection.
		             Set.
		             Dictionary }.
	listWithFilter items: listItems.
	listWithFilter list display: [ :each | each name asHex ].
	listWithFilter filterListItems: 'Collection' asHex.
	self assertCollection: listWithFilter items hasSameElements: { 
			OrderedCollection.
			SequenceableCollection }.
	listWithFilter filterListItems: 'xyz'.
	self assertEmpty: listWithFilter items.
	listWithFilter filterListItems: 'Array' asHex.
	self
		assertCollection: listWithFilter items
		hasSameElements: { Array }.
	listWithFilter filterListItems: ''.
	self
		assertCollection: listWithFilter items
		hasSameElements: listItems
]

{ #category : #test }
SpListWithFilterPresenterTest >> testInitializePresenters [

	self assert: listWithFilter list isNotNil.
	self assert: listWithFilter filterInput isNotNil.
	self assertCollection: listWithFilter focusOrder equals: { 
			listWithFilter list.
			listWithFilter filterInput } asOrderedCollection
]

{ #category : #test }
SpListWithFilterPresenterTest >> testItemFilter [

	| filterBlock |
	filterBlock := [ :item :pattern | 
	               item asLowercase includesSubstring:
		               pattern asLowercase ].
	listWithFilter itemFilter: filterBlock.
	self assert: listWithFilter itemFilter equals: filterBlock
]

{ #category : #test }
SpListWithFilterPresenterTest >> testItems [

	listWithFilter items: { Array }.
	self assertCollection: listWithFilter list items hasSameElements: { Array }
]
