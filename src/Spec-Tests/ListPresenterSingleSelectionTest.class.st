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

	window := presenter
		beSingleSelection;
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectAllDoesNotRaiseEvent [
	"Because it does nothing in single selection mode"
	| events |
	events := 0.
	presenter whenSelectionChangedDo: [ :selection | events := events + 1 ].

	presenter selectAll.

	self assert: events equals: 0
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectAllDoesNotSelect [
	presenter selectAll.

	self assert: presenter selection isEmpty
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectAllWithExistingSelectionLeavesSelection [
	presenter
		selectIndex: 1;
		selectAll.

	self assert: (presenter selection includesIndex: 1)
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectIndexOutsideRangeUnsetsSelectedIndex [
	presenter selectIndex: 4.

	self assert: (presenter selection includesIndex: 0)
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectIndexOutsideRangeUnsetsSelectedItem [

	presenter selectIndex: 4.
	self assert: presenter selection selectedItem equals: nil
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectIndexSetsSelectedIndex [

	presenter selectIndex: 1.
	self assert: presenter selection selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectIndexSetsSelectedItem [

	presenter selectIndex: 1.
	self assert: presenter selection selectedItem equals: 10
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSelectItemOutsideRangeUnsetsSelectedIndex [
	
	presenter selectItem: 40.
	self assert: presenter selection selectedIndex equals: 0
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSelectItemOutsideRangeUnsetsSelectedItem [

	presenter selectItem: 40.
	self assert: presenter selection selectedItem equals: nil
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSelectItemSetsSelectedIndex [

	presenter selectItem: 20.
	self assert: presenter selection selectedIndex equals: 2
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSelectItemSetsSelectedItem [
	presenter selectItem: 20.
	self assert: presenter selection selectedItem equals: 20
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSelectMultipleIndexesRaisesSelectionChangeEventMultipleTimes [
	| events |
	events := 0.
	presenter whenSelectionChangedDo: [ :selection | events := events + 1 ].

	presenter	selectIndex: 1.
	presenter	selectIndex: 3.

	self assert: events equals: 2
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexOutsideRangeRaisesSelectionChangeEventWithUnsetIndex [
	| selectedIndex |
	presenter
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter selectIndex: 4.
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexOutsideRangeRaisesSelectionChangeEventWithUnsetItem [
	| selectedItem |
	presenter
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	presenter selectIndex: 4.
	self assert: selectedItem equals: nil
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter selectIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedItem [
	| selectedElement |

	presenter
		whenSelectionChangedDo: [ :selection | selectedElement := selection selectedItem ].
	presenter selectIndex: 1.
	self assert: selectedElement equals: 10
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection
		whenChangedDo: [ :selection | 
			selectedIndex := selection selectedIndex ].
	presenter selectIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testSetSelectIndexRaisesSelectionItemChangeEventWithSelectedIndex [
	| selectedItem |
	presenter
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	presenter selectIndex: 1.
	self assert: selectedItem equals: 10
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemOutsideRangeRaisesSelectionChangeEventWithUnsetIndex [
	| selectedIndex |

	presenter
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter selectItem: 40.
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemOutsideRangeRaisesSelectionChangeEventWithUnsetItem [
	| selectedItem |
	presenter
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	presenter selectItem: 40.
	self assert: selectedItem equals: nil
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedIndex [
	| selectedIndex |

	presenter
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter selectItem: 20.
	self assert: selectedIndex equals: 2
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedItem [
	| selectedElement |
	presenter
		whenSelectionChangedDo: [ :selection | selectedElement := selection selectedItem ].
	presenter selectItem: 20.
	self assert: selectedElement equals: 20
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection
		whenChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter selectItem: 10.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-item' }
ListPresenterSingleSelectionTest >> testSetSelectItemRaisesSelectionItemChangeEventWithSelectedItem [
	| selectedItem |
	presenter
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	presenter selectItem: 10.
	self assert: selectedItem equals: 10
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testUnselectAllRaisesSelectionEventOnce [
	"Because it does nothing in single selection mode"
	| events |
	events := 0.
	presenter whenSelectionChangedDo: [ :selection | events := events + 1 ].

	presenter unselectAll.

	self assert: events equals: 1
]

{ #category : #'tests-singleselection-index' }
ListPresenterSingleSelectionTest >> testUnselectAllUnselectsSingleSelection [

	presenter
		selectIndex: 1;
		unselectAll.
	self assert: presenter selection isEmpty
]
