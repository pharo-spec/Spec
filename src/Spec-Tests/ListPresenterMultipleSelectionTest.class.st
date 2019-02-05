Class {
	#name : #ListPresenterMultipleSelectionTest,
	#superclass : #SpecTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
ListPresenterMultipleSelectionTest >> classToTest [
	^ ListPresenter
]

{ #category : #running }
ListPresenterMultipleSelectionTest >> setUp [

	super setUp.
	window := presenter
		beMultipleSelection;
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectAllRaisesSelectionEventOnce [
	"Because it does nothing in single selection mode"
	| events |
	events := 0.
	presenter whenSelectionChangedDo: [ :selection | events := events + 1 ].

	presenter selectAll.

	self assert: events equals: 1
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectAllSelectsAllItems [

	presenter selectAll.
	self assert: presenter selection selectedItems asSet equals: presenter model items asSet
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexAddsIndexToSelectedIndexList [

	presenter selectIndex: 1.
	self assert: (presenter selection includesIndex: 1)
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexAddsItemToSelectedItemList [

	presenter selectIndex: 1.
	self assert: (presenter selection includesItem: 10)
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexOutsideRangeHasNoSelectedIndexes [

	presenter selectIndex: 4.
	self assert: presenter selection selectedIndexes isEmpty
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexOutsideRangeHasNoSelectedItems [

	presenter selectIndex: 4.
	self assert: presenter selection selectedItems isEmpty
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexOutsideRangeIsEmpty [

	presenter selectIndex: 4.
	self assert: presenter selection isEmpty
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexThenSelectOutsideRangeKeepsFirstElement [

	presenter selectIndex: 1.
	presenter selectIndex: 50.
	self assert: (presenter selection includesItem: 10)
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexThenSelectOutsideRangeKeepsFirstIndex [

	presenter selectIndex: 1.
	presenter selectIndex: 50.
	self assert: (presenter selection includesIndex: 1)
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexThenSelectOutsideRangeKeepsSingleSelectedItem [

	presenter selectIndex: 1.
	presenter selectIndex: 50.
	self assert: presenter selection selectedItems size equals: 1
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectItemAddsIndexToSelectedIndexList [

	presenter selectItem: 10.
	self assert: (presenter selection includesIndex: 1)
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectItemAddsItemToSelectedItemList [

	presenter selectItem: 10.
	self assert: (presenter selection includesItem: 10)
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectItemOutsideRangeHasNoSelectedIndexes [

	presenter selectItem: 400.
	self assert: presenter selection selectedIndexes isEmpty
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectItemOutsideRangeHasNoSelectedItems [

	presenter selectIndex: 400.
	self assert: presenter selection selectedItems isEmpty
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectItemOutsideRangeIsEmpty [

	presenter selectItem: 4000.
	self assert: presenter selection isEmpty
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectItemThenSelectOutsideRangeKeepsFirstElement [

	presenter selectItem: 10.
	presenter selectItem: 5000.
	self assert: (presenter selection includesItem: 10)
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectItemThenSelectOutsideRangeKeepsFirstIndex [

	presenter selectItem: 10.
	presenter selectItem: 500.
	self assert: (presenter selection includesIndex: 1)
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectItemThenSelectOutsideRangeKeepsSingleSelectedItem [

	presenter selectItem: 10.
	presenter selectItem: 3000.
	self assert: presenter selection selectedItems size equals: 1
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectMultipleIndexesAddsAllToSelectedIndexList [

	presenter selectIndex: 1.
	presenter selectIndex: 3.
	self assert: (presenter selection includesIndex: 1).
	self assert: (presenter selection includesIndex: 3).
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectMultipleIndexesAddsAllToSelectedItemList [

	presenter selectIndex: 1.
	presenter selectIndex: 3.
	self assert: (presenter selection includesItem: 10).
	self assert: (presenter selection includesItem: 30).
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSelectMultipleIndexesRaisesSelectionChangeEventMultipleTimes [
	| events |
	events := 0.
	presenter whenSelectionChangedDo: [ :selection | events := events + 1 ].

	presenter	selectIndex: 1.
	presenter	selectIndex: 3.

	self assert: events equals: 2
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectMultipleItemAddsAllToSelectedIndexList [

	presenter selectItem: 10.
	presenter selectItem: 30.
	self assert: (presenter selection includesIndex: 1).
	self assert: (presenter selection includesIndex: 3).
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectMultipleItemsAddsAllToSelectedItemList [

	presenter selectItem: 10.
	presenter selectItem: 30.
	self assert: (presenter selection includesItem: 10).
	self assert: (presenter selection includesItem: 30).
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSelectMultipleItemsRaisesSelectionChangeEventMultipleTimes [
	| events |
	events := 0.
	presenter whenSelectionChangedDo: [ :selection | events := events + 1 ].

	presenter selectItem: 10.
	presenter selectItem: 30.

	self assert: events equals: 2
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSetSelectIndexOutsideRangeDoesNotModifySelection [

	presenter whenSelectionChangedDo: [ :selection | self fail ].
	
	presenter selectIndex: 4.
	"If we arrive here and the test did not fail, we succeeded"
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedIndex [
	| selectedIndexes |
	presenter
		whenSelectionChangedDo: [ :selection | selectedIndexes := selection selectedIndexes ].
	presenter selectIndex: 1.
	self assert: (selectedIndexes includes: 1)
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedItem [
	| selectedItems |
	presenter
		whenSelectionChangedDo: [ :selection | selectedItems := selection selectedItems ].
	presenter selectIndex: 1.
	self assert: (selectedItems includes: 10)
]

{ #category : #'tests-item' }
ListPresenterMultipleSelectionTest >> testSetSelectItemOutsideRangeDoesNotModifySelection [

	presenter whenSelectionChangedDo: [ :selection | self fail ].
	
	presenter selectItem: 100.
	"If we arrive here and the test did not fail, we succeeded"
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testUnselectAllRaisesSelectionEventOnce [
	"Because it does nothing in single selection mode"
	| events |
	events := 0.
	presenter whenSelectionChangedDo: [ :selection | events := events + 1 ].

	presenter unselectAll.

	self assert: events equals: 1
]

{ #category : #'tests-index' }
ListPresenterMultipleSelectionTest >> testUnselectAllUnselectsall [

	presenter
		selectIndex: 1;
		unselectAll.
	self assert: presenter selection isEmpty
]
