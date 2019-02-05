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
	window := testedInstance
		beMultipleSelection;
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #tests }
ListPresenterMultipleSelectionTest >> testExample [

	^ self skip
]

{ #category : #tests }
ListPresenterMultipleSelectionTest >> testOpenWithSpec [

	^ self skip
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexAddsIndexToSelectedIndexList [

	testedInstance selectIndex: 1.
	self assert: (testedInstance selection includesIndex: 1)
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexAddsItemToSelectedItemList [

	testedInstance selectIndex: 1.
	self assert: (testedInstance selection includesItem: 10)
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexOutsideRangeHasNoSelectedIndexes [

	testedInstance selectIndex: 4.
	self assert: testedInstance selection selectedIndexes isEmpty
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexOutsideRangeHasNoSelectedItems [

	testedInstance selectIndex: 4.
	self assert: testedInstance selection selectedItems isEmpty
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexOutsideRangeIsEmpty [

	testedInstance selectIndex: 4.
	self assert: testedInstance selection isEmpty
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexThenSelectOutsideRangeKeepsFirstElement [

	testedInstance selectIndex: 1.
	testedInstance selectIndex: 50.
	self assert: (testedInstance selection includesItem: 10)
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexThenSelectOutsideRangeKeepsFirstIndex [

	testedInstance selectIndex: 1.
	testedInstance selectIndex: 50.
	self assert: (testedInstance selection includesIndex: 1)
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectIndexThenSelectOutsideRangeKeepsSingleSelectedItem [

	testedInstance selectIndex: 1.
	testedInstance selectIndex: 50.
	self assert: testedInstance selection selectedItems size equals: 1
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectItemAddsIndexToSelectedIndexList [

	testedInstance selectItem: 10.
	self assert: (testedInstance selection includesIndex: 1)
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectItemAddsItemToSelectedItemList [

	testedInstance selectItem: 10.
	self assert: (testedInstance selection includesItem: 10)
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectItemOutsideRangeHasNoSelectedIndexes [

	testedInstance selectItem: 400.
	self assert: testedInstance selection selectedIndexes isEmpty
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectItemOutsideRangeHasNoSelectedItems [

	testedInstance selectIndex: 400.
	self assert: testedInstance selection selectedItems isEmpty
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectItemOutsideRangeIsEmpty [

	testedInstance selectItem: 4000.
	self assert: testedInstance selection isEmpty
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectItemThenSelectOutsideRangeKeepsFirstElement [

	testedInstance selectItem: 10.
	testedInstance selectItem: 5000.
	self assert: (testedInstance selection includesItem: 10)
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectItemThenSelectOutsideRangeKeepsFirstIndex [

	testedInstance selectItem: 10.
	testedInstance selectItem: 500.
	self assert: (testedInstance selection includesIndex: 1)
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectItemThenSelectOutsideRangeKeepsSingleSelectedItem [

	testedInstance selectItem: 10.
	testedInstance selectItem: 3000.
	self assert: testedInstance selection selectedItems size equals: 1
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectMultipleIndexesAddsAllToSelectedIndexList [

	testedInstance selectIndex: 1.
	testedInstance selectIndex: 3.
	self assert: (testedInstance selection includesIndex: 1).
	self assert: (testedInstance selection includesIndex: 3).
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectMultipleIndexesAddsAllToSelectedItemList [

	testedInstance selectIndex: 1.
	testedInstance selectIndex: 3.
	self assert: (testedInstance selection includesItem: 10).
	self assert: (testedInstance selection includesItem: 30).
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectMultipleIndexesRaisesSelectionChangeEventMultipleTimes [
	| events |
	events := 0.
	testedInstance whenSelectionChangedDo: [ :selection | events := events + 1 ].

	testedInstance	selectIndex: 1.
	testedInstance	selectIndex: 3.

	self assert: events equals: 2
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectMultipleItemAddsAllToSelectedIndexList [

	testedInstance selectItem: 10.
	testedInstance selectItem: 30.
	self assert: (testedInstance selection includesIndex: 1).
	self assert: (testedInstance selection includesIndex: 3).
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectMultipleItemsAddsAllToSelectedItemList [

	testedInstance selectItem: 10.
	testedInstance selectItem: 30.
	self assert: (testedInstance selection includesItem: 10).
	self assert: (testedInstance selection includesItem: 30).
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSelectMultipleItemsRaisesSelectionChangeEventMultipleTimes [
	| events |
	events := 0.
	testedInstance whenSelectionChangedDo: [ :selection | events := events + 1 ].

	testedInstance selectItem: 10.
	testedInstance selectItem: 30.

	self assert: events equals: 2
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSetSelectIndexOutsideRangeDoesNotModifySelection [

	testedInstance whenSelectionChangedDo: [ :selection | self fail ].
	
	testedInstance selectIndex: 4.
	"If we arrive here and the test did not fail, we succeeded"
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedIndex [
	| selectedIndexes |
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedIndexes := selection selectedIndexes ].
	testedInstance selectIndex: 1.
	self assert: (selectedIndexes includes: 1)
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedItem [
	| selectedItems |
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedItems := selection selectedItems ].
	testedInstance selectIndex: 1.
	self assert: (selectedItems includes: 10)
]

{ #category : #'tests-multipleselection-index' }
ListPresenterMultipleSelectionTest >> testSetSelectItemOutsideRangeDoesNotModifySelection [

	testedInstance whenSelectionChangedDo: [ :selection | self fail ].
	
	testedInstance selectItem: 100.
	"If we arrive here and the test did not fail, we succeeded"
]
