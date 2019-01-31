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
	
	self assert: testedInstance selectedIndex equals: 0
]

{ #category : #'tests-doubleClick' }
ListPresenterTest >> testDoubleClickOutsideSelectionUnsetsSelectedItem [

	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance doubleClickAtIndex: 4.
	
	self assert: testedInstance selectedItem equals: nil
]

{ #category : #'tests-doubleClick' }
ListPresenterTest >> testDoubleClickSelectsItem [

	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance doubleClickAtIndex: 2.
	
	self assert: testedInstance selectedIndex equals: 2
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

{ #category : #'tests-selection-index' }
ListPresenterTest >> testSelectIndexOutsideRangeUnsetsSelectedIndex [

	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
		
	testedInstance selectedIndex: 4.
	
	self assert: testedInstance selectedIndex equals: 0
]

{ #category : #'tests-selection-index' }
ListPresenterTest >> testSelectIndexOutsideRangeUnsetsSelectedItem [

	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
		
	testedInstance selectedIndex: 4.
	
	self assert: testedInstance selectedItem equals: nil
]

{ #category : #'tests-selection-index' }
ListPresenterTest >> testSelectIndexSetsSelectedIndex [

	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
		
	testedInstance selectedIndex: 1.
	
	self assert: testedInstance selectedIndex equals: 1
]

{ #category : #'tests-selection-index' }
ListPresenterTest >> testSelectIndexSetsSelectedItem [

	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
		
	testedInstance selectedIndex: 1.
	
	self assert: testedInstance selectedItem equals: 10
]

{ #category : #'tests-selection-item' }
ListPresenterTest >> testSelectItemOutsideRangeUnsetsSelectedIndex [

	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
		
	testedInstance selectedItem: 40.
	
	self assert: testedInstance selectedIndex equals: 0
]

{ #category : #'tests-selection-item' }
ListPresenterTest >> testSelectItemOutsideRangeUnsetsSelectedItem [

	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
		
	testedInstance selectedItem: 40.
	
	self assert: testedInstance selectedItem equals: nil
]

{ #category : #'tests-selection-item' }
ListPresenterTest >> testSelectItemSetsSelectedIndex [

	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
		
	testedInstance selectedItem: 20.
	
	self assert: testedInstance selectedIndex equals: 2
]

{ #category : #'tests-selection-item' }
ListPresenterTest >> testSelectItemSetsSelectedItem [

	window := testedInstance
		items: #(10 20 30);
		openWithSpec.
		
	testedInstance selectedItem: 20.
	
	self assert: testedInstance selectedItem equals: 20
]

{ #category : #'tests-selection-index' }
ListPresenterTest >> testSetSelectIndexOutsideRangeRaisesSelectionChangeEventWithUnsetIndex [

	| selectedIndex |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectionChangedDo: [ :selection | selectedIndex := selection first ].
	testedInstance selectedIndex: 4.
	
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-selection-index' }
ListPresenterTest >> testSetSelectIndexOutsideRangeRaisesSelectionChangeEventWithUnsetItem [

	| selectedItem |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectionChangedDo: [ :selection | selectedItem := selection second ].
	testedInstance selectedIndex: 4.
	
	self assert: selectedItem equals: nil
]

{ #category : #'tests-selection-index' }
ListPresenterTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedIndex [

	| selectedIndex |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectionChangedDo: [ :selection | selectedIndex := selection first ].
	testedInstance selectedIndex: 1.
	
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-selection-index' }
ListPresenterTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedItem [

	| selectedElement |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectionChangedDo: [ :selection | selectedElement := selection second ].
	testedInstance selectedIndex: 1.
	
	self assert: selectedElement equals: 10
]

{ #category : #'tests-selection-index' }
ListPresenterTest >> testSetSelectIndexRaisesSelectionIndexChangeEventWithSelectedIndex [

	| selectedIndex |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectedIndexChangedDo: [ :selection | selectedIndex := selection ].
	testedInstance selectedIndex: 1.
	
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-selection-index' }
ListPresenterTest >> testSetSelectIndexRaisesSelectionItemChangeEventWithSelectedIndex [

	| selectedItem |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectedItemChangedDo: [ :selection | selectedItem := selection ].
	testedInstance selectedIndex: 1.
	
	self assert: selectedItem equals: 10
]

{ #category : #'tests-selection-item' }
ListPresenterTest >> testSetSelectItemOutsideRangeRaisesSelectionChangeEventWithUnsetIndex [

	| selectedIndex |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectionChangedDo: [ :selection | selectedIndex := selection first ].
	testedInstance selectedItem: 40.
	
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-selection-item' }
ListPresenterTest >> testSetSelectItemOutsideRangeRaisesSelectionChangeEventWithUnsetItem [

	| selectedItem |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectionChangedDo: [ :selection | selectedItem := selection second ].
	testedInstance selectedItem: 40.
	
	self assert: selectedItem equals: nil
]

{ #category : #'tests-selection-item' }
ListPresenterTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedIndex [

	| selectedIndex |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectionChangedDo: [ :selection | selectedIndex := selection first ].
	testedInstance selectedItem: 20.
	
	self assert: selectedIndex equals: 2
]

{ #category : #'tests-selection-item' }
ListPresenterTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedItem [

	| selectedElement |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectionChangedDo: [ :selection | selectedElement := selection second ].
	testedInstance selectedItem: 20.
	
	self assert: selectedElement equals: 20
]

{ #category : #'tests-selection-item' }
ListPresenterTest >> testSetSelectItemRaisesSelectionIndexChangeEventWithSelectedIndex [

	| selectedIndex |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectedIndexChangedDo: [ :selection | selectedIndex := selection ].
	testedInstance selectedItem: 10.
	
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-selection-item' }
ListPresenterTest >> testSetSelectItemRaisesSelectionItemChangeEventWithSelectedItem [

	| selectedItem |
	window := testedInstance
		items: #(10 20 30);
		openWithSpec.

	testedInstance whenSelectedItemChangedDo: [ :selection | selectedItem := selection ].
	testedInstance selectedItem: 10.
	
	self assert: selectedItem equals: 10
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
