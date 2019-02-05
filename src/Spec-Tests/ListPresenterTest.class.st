"
testing ListComposablePresenter
"
Class {
	#name : #ListPresenterTest,
	#superclass : #SpecTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
ListPresenterTest >> classToTest [
	^ ListPresenter
]

{ #category : #'tests-doubleClick' }
ListPresenterTest >> testDoubleClickCallsDoubleClickAction [

	| doubleClickInvoked |
	doubleClickInvoked := false.

	window := testedInstance
		items: #(10 20 30);
		doubleClickAction: [ doubleClickInvoked := true ];
		openWithSpec.

	testedInstance doubleClickAtIndex: 2.
	
	self assert: doubleClickInvoked
]

{ #category : #'tests-doubleClick' }
ListPresenterTest >> testDoubleClickOutsideSelectionUnsetsSelectedIndex [
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
	testedInstance doubleClickAtIndex: 4.
	self assert: testedInstance selection selectedIndex equals: 0
]

{ #category : #'tests-doubleClick' }
ListPresenterTest >> testDoubleClickOutsideSelectionUnsetsSelectedItem [
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
	testedInstance doubleClickAtIndex: 4.
	self assert: testedInstance selection selectedItem equals: nil
]

{ #category : #'tests-doubleClick' }
ListPresenterTest >> testDoubleClickSelectsItem [
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
	testedInstance doubleClickAtIndex: 2.
	self assert: testedInstance selection selectedIndex equals: 2
]

{ #category : #tests }
ListPresenterTest >> testSelectAll [
	| items |
	items := #(#AAA #BBB #CCC).
	testedInstance items: items.
	testedInstance beMultipleSelection.
	self assertCollection: testedInstance selectedItems hasSameElements: #().
	testedInstance selectAll.
	self assertCollection: testedInstance selectedItems hasSameElements: items
]

{ #category : #'tests-smoke' }
ListPresenterTest >> testSmokeOpenEmptyTablePresenter [

	window := testedInstance openWithSpec
]

{ #category : #'tests-smoke' }
ListPresenterTest >> testSmokeOpenTablePresenterWithItemsButNoColumns [

	window := testedInstance
		items: #(1 2 3);
		openWithSpec.
]

{ #category : #tests }
ListPresenterTest >> testWhenListChanged [
	"Two stages list changed notification."

	50
		timesRepeat: [ | ok |
			ok := false.
			testedInstance := ListPresenter new.
			testedInstance
				items: #(1 2);
				whenListChanged: [ :aList | ok := aList = testedInstance listItems ];
				listItems;
				"Call listItems to set the cache"
				items: #(1 2 3).
			self assert: ok ]
]

{ #category : #tests }
ListPresenterTest >> testWhenListChangedOldContents [
	"access to old and new contents in whenListChanged."

	| oldL newL |
	oldL := #(1 2).
	newL := #(1 2 3).
	testedInstance items: oldL.
	testedInstance
		whenListChanged: [ :aList :anOldList | 
			self assert: oldL equals: anOldList.
			self assert: newL equals: aList ].
	testedInstance listItems.	"Call listItems to set the cache"
	testedInstance items: #(1 2 3)
]
