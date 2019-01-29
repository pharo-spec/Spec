Class {
	#name : #TablePresenterTest,
	#superclass : #SpecTestCase,
	#instVars : [
		'presenter'
	],
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
TablePresenterTest >> classToTest [
	
	^ TablePresenter
]

{ #category : #tests }
TablePresenterTest >> setUp [
	super setUp.
	presenter := TablePresenter new.
]

{ #category : #tests }
TablePresenterTest >> testSelectIndexSetsSelectedIndex [

	window := presenter
		items: #(10 20 30);
		openWithSpec.
		
	presenter setSelectedIndex: 1.
	
	self assert: presenter selectedIndex equals: 1
]

{ #category : #tests }
TablePresenterTest >> testSelectIndexSetsSelectedItem [

	window := presenter
		items: #(10 20 30);
		openWithSpec.
		
	presenter setSelectedIndex: 1.
	
	self assert: presenter selectedItem equals: 10
]

{ #category : #tests }
TablePresenterTest >> testSelectValueSetsSelectedIndex [

	window := presenter
		items: #(10 20 30);
		openWithSpec.
		
	presenter setSelectedItem: 20.
	
	self assert: presenter selectedIndex equals: 2
]

{ #category : #tests }
TablePresenterTest >> testSelectValueSetsSelectedItem [

	window := presenter
		items: #(10 20 30);
		openWithSpec.
		
	presenter setSelectedItem: 20.
	
	self assert: presenter selectedItem equals: 20
]

{ #category : #tests }
TablePresenterTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedIndex [

	| selectedIndex |
	window := presenter
		items: #(10 20 30);
		openWithSpec.

	presenter whenSelectionChangedDo: [ :selection | selectedIndex := selection first ].
	presenter setSelectedIndex: 1.
	
	self assert: selectedIndex equals: 1
]

{ #category : #tests }
TablePresenterTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedItem [

	| selectedElement |
	window := presenter
		items: #(10 20 30);
		openWithSpec.

	presenter whenSelectionChangedDo: [ :selection | selectedElement := selection second ].
	presenter setSelectedIndex: 1.
	
	self assert: selectedElement equals: 10
]

{ #category : #tests }
TablePresenterTest >> testSetSelectIndexRaisesSelectionIndexChangeEventWithSelectedIndex [

	| selectedIndex |
	window := presenter
		items: #(10 20 30);
		openWithSpec.

	presenter whenSelectedIndexChangedDo: [ :selection | selectedIndex := selection ].
	presenter setSelectedIndex: 1.
	
	self assert: selectedIndex equals: 1
]

{ #category : #tests }
TablePresenterTest >> testSetSelectIndexRaisesSelectionItemChangeEventWithSelectedIndex [

	| selectedItem |
	window := presenter
		items: #(10 20 30);
		openWithSpec.

	presenter whenSelectedItemChangedDo: [ :selection | selectedItem := selection ].
	presenter setSelectedIndex: 1.
	
	self assert: selectedItem equals: 10
]

{ #category : #tests }
TablePresenterTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedIndex [

	| selectedIndex |
	window := presenter
		items: #(10 20 30);
		openWithSpec.

	presenter whenSelectionChangedDo: [ :selection | selectedIndex := selection first ].
	presenter setSelectedItem: 20.
	
	self assert: selectedIndex equals: 2
]

{ #category : #tests }
TablePresenterTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedItem [

	| selectedElement |
	window := presenter
		items: #(10 20 30);
		openWithSpec.

	presenter whenSelectionChangedDo: [ :selection | selectedElement := selection second ].
	presenter setSelectedItem: 20.
	
	self assert: selectedElement equals: 20
]

{ #category : #tests }
TablePresenterTest >> testSetSelectItemRaisesSelectionIndexChangeEventWithSelectedIndex [

	| selectedIndex |
	window := presenter
		items: #(10 20 30);
		openWithSpec.

	presenter whenSelectedIndexChangedDo: [ :selection | selectedIndex := selection ].
	presenter setSelectedItem: 10.
	
	self assert: selectedIndex equals: 1
]

{ #category : #tests }
TablePresenterTest >> testSmokeOpenEmptyTablePresenter [

	window := presenter openWithSpec
]

{ #category : #tests }
TablePresenterTest >> testSmokeOpenTablePresenterWithItemsButNoColumns [

	window := presenter
		items: #(1 2 3);
		openWithSpec.
]
