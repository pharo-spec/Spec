Class {
	#name : #ListPresenterSingleSelectionTest,
	#superclass : #SpecTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
ListPresenterSingleSelectionTest >> classToTest [
	^ ListPresenter
]

{ #category : #running }
ListPresenterSingleSelectionTest >> setUp [

	super setUp.

	window := testedInstance
		beSingleSelection;
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectAllDoesNotRaiseEvent [
	"Because it does nothing in single selection mode"
	| events |
	events := 0.
	testedInstance whenSelectionChangedDo: [ :selection | events := events + 1 ].

	testedInstance selectAll.

	self assert: events equals: 0
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectAllDoesNotSelect [
	testedInstance selectAll.

	self assert: (testedInstance selection isEmpty)
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectAllWithExistingSelectionLeavesSelection [
	testedInstance
		selectIndex: 1;
		selectAll.

	self assert: (testedInstance selection includesIndex: 1)
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectIndexOutsideRangeUnsetsSelectedIndex [
	testedInstance selectIndex: 4.

	self assert: (testedInstance selection includesIndex: 0)
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectIndexOutsideRangeUnsetsSelectedItem [

	testedInstance selectIndex: 4.
	self assert: testedInstance selection selectedItem equals: nil
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectIndexSetsSelectedIndex [

	testedInstance selectIndex: 1.
	self assert: testedInstance selection selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectIndexSetsSelectedItem [

	testedInstance selectIndex: 1.
	self assert: testedInstance selection selectedItem equals: 10
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSelectItemOutsideRangeUnsetsSelectedIndex [
	
	testedInstance selectItem: 40.
	self assert: testedInstance selection selectedIndex equals: 0
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSelectItemOutsideRangeUnsetsSelectedItem [

	testedInstance selectItem: 40.
	self assert: testedInstance selection selectedItem equals: nil
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSelectItemSetsSelectedIndex [

	testedInstance selectItem: 20.
	self assert: testedInstance selection selectedIndex equals: 2
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSelectItemSetsSelectedItem [
	testedInstance selectItem: 20.
	self assert: testedInstance selection selectedItem equals: 20
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectMultipleIndexesRaisesSelectionChangeEventMultipleTimes [
	| events |
	events := 0.
	testedInstance whenSelectionChangedDo: [ :selection | events := events + 1 ].

	testedInstance	selectIndex: 1.
	testedInstance	selectIndex: 3.

	self assert: events equals: 2
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexOutsideRangeRaisesSelectionChangeEventWithUnsetIndex [
	| selectedIndex |
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	testedInstance selectIndex: 4.
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexOutsideRangeRaisesSelectionChangeEventWithUnsetItem [
	| selectedItem |
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	testedInstance selectIndex: 4.
	self assert: selectedItem equals: nil
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedIndex [
	| selectedIndex |
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	testedInstance selectIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedItem [
	| selectedElement |

	testedInstance
		whenSelectionChangedDo: [ :selection | selectedElement := selection selectedItem ].
	testedInstance selectIndex: 1.
	self assert: selectedElement equals: 10
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	testedInstance selection
		whenChangedDo: [ :selection | 
			selectedIndex := selection selectedIndex ].
	testedInstance selectIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexRaisesSelectionItemChangeEventWithSelectedIndex [
	| selectedItem |

	testedInstance
		whenSelectedItemChangedDo: [ :selection | selectedItem := selection ].
	testedInstance selectIndex: 1.
	self assert: selectedItem equals: 10
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemOutsideRangeRaisesSelectionChangeEventWithUnsetIndex [
	| selectedIndex |

	testedInstance
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	testedInstance selectItem: 40.
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemOutsideRangeRaisesSelectionChangeEventWithUnsetItem [
	| selectedItem |
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	testedInstance selectItem: 40.
	self assert: selectedItem equals: nil
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedIndex [
	| selectedIndex |

	testedInstance
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	testedInstance selectItem: 20.
	self assert: selectedIndex equals: 2
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedItem [
	| selectedElement |
	testedInstance
		whenSelectionChangedDo: [ :selection | selectedElement := selection selectedItem ].
	testedInstance selectItem: 20.
	self assert: selectedElement equals: 20
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	testedInstance selection
		whenChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	testedInstance selectItem: 10.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemRaisesSelectionItemChangeEventWithSelectedItem [
	| selectedItem |
	testedInstance
		whenSelectedItemChangedDo: [ :selection | selectedItem := selection ].
	testedInstance selectItem: 10.
	self assert: selectedItem equals: 10
]
