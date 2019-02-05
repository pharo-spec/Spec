Class {
	#name : #ListMorphicAdapterSingleSelectionTest,
	#superclass : #SpecTestCase,
	#category : #'Spec-Tests-MorphicAdapters'
}

{ #category : #running }
ListMorphicAdapterSingleSelectionTest >> classToTest [
	^ ListPresenter
]

{ #category : #running }
ListMorphicAdapterSingleSelectionTest >> setUp [

	super setUp.

	window := presenter
		beSingleSelection;
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSelectAllDoesNotRaiseEvent [
	"Because it does nothing in single selection mode"
	| events |
	events := 0.
	presenter whenSelectionChangedDo: [ :selection | events := events + 1 ].

	presenter selectAll.

	self assert: events equals: 0
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSelectAllDoesNotSelect [
	presenter selectAll.

	self assert: (presenter selection isEmpty)
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSelectAllWithExistingSelectionLeavesSelection [
	presenter
		selectIndex: 1;
		selectAll.

	self assert: (presenter selection includesIndex: 1)
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSelectIndexOutsideRangeUnsetsSelectedIndex [
	presenter selectIndex: 4.

	self assert: (presenter selection includesIndex: 0)
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSelectIndexOutsideRangeUnsetsSelectedItem [

	presenter selectIndex: 4.
	self assert: presenter selection selectedItem equals: nil
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSelectIndexSetsSelectedIndex [

	presenter selectIndex: 1.
	self halt.
	self assert: presenter selection selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSelectIndexSetsSelectedItem [

	presenter selectIndex: 1.
	self assert: presenter selection selectedItem equals: 10
]

{ #category : #'tests-singleselection-item' }
ListMorphicAdapterSingleSelectionTest >> testSelectItemOutsideRangeUnsetsSelectedIndex [
	
	presenter selectItem: 40.
	self assert: presenter selection selectedIndex equals: 0
]

{ #category : #'tests-singleselection-item' }
ListMorphicAdapterSingleSelectionTest >> testSelectItemOutsideRangeUnsetsSelectedItem [

	presenter selectItem: 40.
	self assert: presenter selection selectedItem equals: nil
]

{ #category : #'tests-singleselection-item' }
ListMorphicAdapterSingleSelectionTest >> testSelectItemSetsSelectedIndex [

	presenter selectItem: 20.
	self assert: presenter selection selectedIndex equals: 2
]

{ #category : #'tests-singleselection-item' }
ListMorphicAdapterSingleSelectionTest >> testSelectItemSetsSelectedItem [
	presenter selectItem: 20.
	self assert: presenter selection selectedItem equals: 20
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterSingleSelectionTest >> testSelectManyIndexesKeepsLastSelectionInWidget [

	presenter selectIndex: 1.
	presenter selectIndex: 2.
	self assert: presenter widget widget selectedRowIndexes equals: #(2)
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSelectMultipleIndexesRaisesSelectionChangeEventMultipleTimes [
	| events |
	events := 0.
	presenter whenSelectionChangedDo: [ :selection | events := events + 1 ].

	presenter	selectIndex: 1.
	presenter	selectIndex: 3.

	self assert: events equals: 2
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterSingleSelectionTest >> testSelectPresenterIndexOutsideRangeUnsetsSelectedIndexInWidget [

	presenter selectIndex: 100.
	self assert: presenter widget widget selectedRowIndexes isEmpty
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterSingleSelectionTest >> testSelectPresenterIndexSetsSelectedIndexInWidget [

	presenter selectIndex: 1.
	self assert: (presenter widget widget selectedRowIndexes includes: 1)
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterSingleSelectionTest >> testSelectPresenterItemSetsSelectedIndexInWidget [

	presenter selectItem: 20.
	self assert: (presenter widget widget selectedRowIndexes includes: 2)
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectIndexOutsideRangeRaisesSelectionChangeEventWithUnsetIndex [
	| selectedIndex |
	presenter
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter selectIndex: 4.
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectIndexOutsideRangeRaisesSelectionChangeEventWithUnsetItem [
	| selectedItem |
	presenter
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	presenter selectIndex: 4.
	self assert: selectedItem equals: nil
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter selectIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectIndexRaisesSelectionChangeEventWithSelectedItem [
	| selectedElement |

	presenter
		whenSelectionChangedDo: [ :selection | selectedElement := selection selectedItem ].
	presenter selectIndex: 1.
	self assert: selectedElement equals: 10
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection
		whenChangedDo: [ :selection | 
			selectedIndex := selection selectedIndex ].
	presenter selectIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectIndexRaisesSelectionItemChangeEventWithSelectedIndex [
	| selectedItem |
	presenter
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	presenter selectIndex: 1.
	self assert: selectedItem equals: 10
]

{ #category : #'tests-singleselection-item' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectItemOutsideRangeRaisesSelectionChangeEventWithUnsetIndex [
	| selectedIndex |

	presenter
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter selectItem: 40.
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-singleselection-item' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectItemOutsideRangeRaisesSelectionChangeEventWithUnsetItem [
	| selectedItem |
	presenter
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	presenter selectItem: 40.
	self assert: selectedItem equals: nil
]

{ #category : #'tests-singleselection-item' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedIndex [
	| selectedIndex |

	presenter
		whenSelectionChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter selectItem: 20.
	self assert: selectedIndex equals: 2
]

{ #category : #'tests-singleselection-item' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectItemRaisesSelectionChangeEventWithSelectedItem [
	| selectedElement |
	presenter
		whenSelectionChangedDo: [ :selection | selectedElement := selection selectedItem ].
	presenter selectItem: 20.
	self assert: selectedElement equals: 20
]

{ #category : #'tests-singleselection-item' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectItemRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection
		whenChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter selectItem: 10.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-singleselection-item' }
ListMorphicAdapterSingleSelectionTest >> testSetSelectItemRaisesSelectionItemChangeEventWithSelectedItem [
	| selectedItem |
	presenter
		whenSelectionChangedDo: [ :selection | selectedItem := selection selectedItem ].
	presenter selectItem: 10.
	self assert: selectedItem equals: 10
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterSingleSelectionTest >> testSetWidgetSelectIndexRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter selection whenChangedDo: [ :selection | 
		counter := counter + 1 ].
	
	presenter widget widget selectRowIndex: 1.
	self assert: counter equals: 1
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterSingleSelectionTest >> testSetWidgetSelectIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection whenChangedDo: [ :selection | 
		selectedIndex := selection selectedIndex ].
	
	presenter widget widget selectRowIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterSingleSelectionTest >> testSubscribeToEventDoesNotRaiseEvent [

	presenter selection
		whenChangedDo: [ :selection | self fail ].
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testUnselectAllRaisesSelectionEventOnce [
	"Because it does nothing in single selection mode"
	| events |
	events := 0.
	presenter whenSelectionChangedDo: [ :selection | events := events + 1 ].

	presenter unselectAll.

	self assert: events equals: 1
]

{ #category : #'tests-singleselection-index' }
ListMorphicAdapterSingleSelectionTest >> testUnselectAllUnselectsSingleSelection [

	presenter
		selectIndex: 1;
		unselectAll.
	self assert: presenter selection isEmpty
]
