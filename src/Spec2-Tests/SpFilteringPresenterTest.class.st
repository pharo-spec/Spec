"
A SpListWithFilterPresenterTest is a test class for testing the behavior of SpListWithFilterPresenter
"
Class {
	#name : #SpFilteringPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'listWithFilter'
	],
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #running }
SpFilteringPresenterTest >> setUp [

	super setUp.
	listWithFilter := SpFilteringListPresenter new
]

{ #category : #test }
SpFilteringPresenterTest >> testFilterListItems [

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
	listWithFilter filterListItems: 'array'.
	self
		assertCollection: listWithFilter items
		hasSameElements: { Array }.
	listWithFilter filterListItems: ''.
	self
		assertCollection: listWithFilter items
		hasSameElements: listItems
]

{ #category : #test }
SpFilteringPresenterTest >> testFilterListItemsWithDifferentDisplay [

	| listItems |
	listItems := { OrderedCollection.
		             Array.
		             SequenceableCollection.
		             Set.
		             Dictionary }.
	listWithFilter items: listItems.
	listWithFilter listPresenter display: [ :each | each name asHex ].
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
SpFilteringPresenterTest >> testInitializePresenters [

	self assert: (listWithFilter listPresenter isMemberOf: SpListPresenter).
	self assert: (listWithFilter filterInputPresenter isMemberOf: SpTextInputFieldPresenter).

]

{ #category : #test }
SpFilteringPresenterTest >> testItemFilter [

	| filterBlock |
	filterBlock := [ :item :pattern | 
	               item asLowercase =
		               pattern asLowercase ].
	listWithFilter itemFilter: filterBlock.
	self assert: listWithFilter itemFilter equals: filterBlock
]

{ #category : #test }
SpFilteringPresenterTest >> testItems [

	listWithFilter items: { Array }.
	self assertCollection: listWithFilter items hasSameElements: { Array }
]

{ #category : #test }
SpFilteringPresenterTest >> testMatchBeginOfString [

	listWithFilter matchBeginOfString.
	listWithFilter items: { 
			Number.
			Character.
			String.
			OrderedCollection.
			HashedCollection.
			Array }.
	listWithFilter applyFilter: 'NUM'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter applyFilter: 'COLLECTION'.
	self assert: listWithFilter items size equals: 0.
	listWithFilter applyFilter: 'ARACTER'.
	self assert: listWithFilter items size equals: 0.
	listWithFilter applyFilter: 'STRIN'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter applyFilter: 'arrAY'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter applyFilter: ''.
	self assert: listWithFilter items size equals: 6
]

{ #category : #test }
SpFilteringPresenterTest >> testMatchSubstring [

	listWithFilter matchSubstring.
	listWithFilter items: { 
			Number.
			Character.
			String.
			OrderedCollection.
			HashedCollection.
			Array }.
	listWithFilter applyFilter: 'BER'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter applyFilter: 'COLLECTION'.
	self assert: listWithFilter items size equals: 2.
	listWithFilter applyFilter: 'TRIN'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter applyFilter: 'arrAY'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter applyFilter: ''.
	self assert: listWithFilter items size equals: 6
]

{ #category : #test }
SpFilteringPresenterTest >> testPrivateMethodFilterListItems [

	listWithFilter matchBeginOfString.
	listWithFilter items: { 
			Number.
			Character.
			String.
			OrderedCollection.
			HashedCollection.
			Array }.
	
	listWithFilter filterListItems: 'NUM'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter filterListItems: 'COLLECTION'.
	self assert: listWithFilter items size equals: 0.
	listWithFilter filterListItems: 'ARACTER'.
	self assert: listWithFilter items size equals: 0.
	listWithFilter filterListItems: 'STRIN'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter filterListItems: 'arrAY'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter filterListItems: ''.
	self assert: listWithFilter items size equals: 6
]

{ #category : #test }
SpFilteringPresenterTest >> testPrivateMethodMatchSubstring [

	listWithFilter matchSubstring.
	listWithFilter items: { 
			Number.
			Character.
			String.
			OrderedCollection.
			HashedCollection.
			Array }.
	listWithFilter filterListItems: 'BER'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter filterListItems: 'COLLECTION'.
	self assert: listWithFilter items size equals: 2.
	listWithFilter filterListItems: 'TRIN'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter filterListItems: 'arrAY'.
	self assert: listWithFilter items size equals: 1.
	listWithFilter filterListItems: ''.
	self assert: listWithFilter items size equals: 6
]
