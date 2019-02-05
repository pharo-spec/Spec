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

{ #category : #'tests-multipleselection-index' }
ListPresenterTest >> testSelectIndexOutsideRangeUnderMultipleSelectionIsEmpty [
	self useMultipleSingleSelectionList.
	testedInstance selectIndex: 4.

	self assert: testedInstance selection isEmpty
]

{ #category : #'tests-singleselection-index' }
ListPresenterTest >> testSelectIndexOutsideRangeUnsetsSelectedIndex [
	self useSingleSelectionList.			
	testedInstance selectIndex: 4.

	self assert: (testedInstance selection includesIndex: 0)
]

{ #category : #'tests-singleselection-index' }
ListPresenterTest >> testSelectIndexOutsideRangeUnsetsSelectedItem [
	self useSingleSelectionList.
	testedInstance selectIndex: 4.
	self assert: testedInstance selection selectedItem equals: nil
]

{ #category : #'tests-singleselection-index' }
ListPresenterTest >> testSelectIndexSetsSelectedIndex [
	self useSingleSelectionList.
	testedInstance selectIndex: 1.
	self assert: testedInstance selection selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListPresenterTest >> testSelectIndexSetsSelectedItem [
	self useSingleSelectionList.
	testedInstance selectIndex: 1.
	self assert: testedInstance selection selectedItem equals: 10
]

{ #category : #'tests-singleselection-item' }
ListPresenterTest >> testSelectItemOutsideRangeUnsetsSelectedIndex [
	self useSingleSelectionList.
	testedInstance selectItem: 40.
	self assert: testedInstance selection selectedIndex equals: 0
]

{ #category : #'tests-singleselection-item' }
ListPresenterTest >> testSelectItemOutsideRangeUnsetsSelectedItem [
	self useSingleSelectionList.
	testedInstance selectItem: 40.
	self assert: testedInstance selection selectedItem equals: nil
]

{ #category : #'tests-singleselection-item' }
ListPresenterTest >> testSelectItemSetsSelectedIndex [
	self useSingleSelectionList.
	testedInstance selectItem: 20.
	self assert: testedInstance selection selectedIndex equals: 2
]

{ #category : #'tests-singleselection-item' }
ListPresenterTest >> testSelectItemSetsSelectedItem [
	self useSingleSelectionList.
	testedInstance selectItem: 20.
	self assert: testedInstance selection selectedItem equals: 20
]

{ #category : #'tests-singleselection-index' }
ListPresenterTest >> testSetSelectIndexOutsideRangeRaisesSelectionChangeEventWithUnsetIndex [
	| selectedIndex |
	self useSingleSelectionList.
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	testedInstance selectIndex: 4.
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-singleselection-index' }
ListPresenterTest >> testSetSelectIndexOutsideRangeRaisesSelectionChangeEventWithUnsetItem [
	| selectedItem |
	self useSingleSelectionList.
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	testedInstance selectIndex: 4.
	self assert: selectedItem equals: nil
]

{ #category : #'tests-singleselection-index' }
ListPresenterTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedIndex [
	| selectedIndex |
	self useSingleSelectionList.
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	testedInstance selectIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListPresenterTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedItem [
	| selectedElement |
	self useSingleSelectionList.
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedElement := selection selectedItem ].
	testedInstance selectIndex: 1.
	self assert: selectedElement equals: 10
]

{ #category : #'tests-singleselection-index' }
ListPresenterTest >> testSetSelectIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	self useSingleSelectionList.
	testedInstance
		whenSelectedIndexChangedDo: [ :selection | selectedIndex := selection ].
	testedInstance selectIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListPresenterTest >> testSetSelectIndexRaisesSelectionItemChangeEventWithSelectedIndex [
	| selectedItem |
	self useSingleSelectionList.
	testedInstance
		whenSelectedItemChangedDo: [ :selection | selectedItem := selection ].
	testedInstance selectIndex: 1.
	self assert: selectedItem equals: 10
]

{ #category : #'tests-singleselection-item' }
ListPresenterTest >> testSetSelectItemOutsideRangeRaisesSelectionChangeEventWithUnsetIndex [
	| selectedIndex |
	self useSingleSelectionList.
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	testedInstance selectItem: 40.
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-singleselection-item' }
ListPresenterTest >> testSetSelectItemOutsideRangeRaisesSelectionChangeEventWithUnsetItem [
	| selectedItem |
	self useSingleSelectionList.
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	testedInstance selectItem: 40.
	self assert: selectedItem equals: nil
]

{ #category : #'tests-singleselection-item' }
ListPresenterTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedIndex [
	| selectedIndex |
	self useSingleSelectionList.
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	testedInstance selectItem: 20.
	self assert: selectedIndex equals: 2
]

{ #category : #'tests-singleselection-item' }
ListPresenterTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedItem [
	| selectedElement |
	self useSingleSelectionList.
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedElement := selection selectedItem ].
	testedInstance selectItem: 20.
	self assert: selectedElement equals: 20
]

{ #category : #'tests-singleselection-item' }
ListPresenterTest >> testSetSelectItemRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	self useSingleSelectionList.
	testedInstance
		whenSelectedIndexChangedDo: [ :selection | selectedIndex := selection ].
	testedInstance selectItem: 10.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-item' }
ListPresenterTest >> testSetSelectItemRaisesSelectionItemChangeEventWithSelectedItem [
	| selectedItem |
	self useSingleSelectionList.
	testedInstance
		whenSelectedItemChangedDo: [ :selection | selectedItem := selection ].
	testedInstance selectItem: 10.
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

{ #category : #running }
ListPresenterTest >> useMultipleSingleSelectionList [

	window := testedInstance
		beMultipleSelection;
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #running }
ListPresenterTest >> useSingleSelectionList [

	window := testedInstance
		beSingleSelection;
		items: #(10 20 30);
		openWithSpec.
]
