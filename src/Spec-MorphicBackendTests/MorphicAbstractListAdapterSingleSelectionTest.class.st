Class {
	#name : #MorphicAbstractListAdapterSingleSelectionTest,
	#superclass : #MorphicAdapterTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #testing }
MorphicAbstractListAdapterSingleSelectionTest class >> isAbstract [
	^ self == MorphicAbstractListAdapterSingleSelectionTest
]

{ #category : #running }
MorphicAbstractListAdapterSingleSelectionTest >> adapter [

	^ presenter adapter
]

{ #category : #running }
MorphicAbstractListAdapterSingleSelectionTest >> setUp [

	super setUp.

	window := presenter
		beSingleSelection;
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #'tests-model-to-widget' }
MorphicAbstractListAdapterSingleSelectionTest >> testSelectManyIndexesKeepsLastSelectionInWidget [
	presenter selectIndex: 1.
	presenter selectIndex: 2.
	self assert: presenter adapter widget selectedRowIndexes equals: #(2)
]

{ #category : #'tests-model-to-widget' }
MorphicAbstractListAdapterSingleSelectionTest >> testSelectPresenterIndexOutsideRangeUnsetsSelectedIndexInWidget [
	presenter selectIndex: 100.
	self assert: presenter adapter widget selectedRowIndexes isEmpty
]

{ #category : #'tests-model-to-widget' }
MorphicAbstractListAdapterSingleSelectionTest >> testSelectPresenterIndexSetsSelectedIndexInWidget [
	presenter selectIndex: 1.
	self
		assert: (presenter adapter widget selectedRowIndexes includes: 1)
]

{ #category : #'tests-model-to-widget' }
MorphicAbstractListAdapterSingleSelectionTest >> testSelectPresenterItemSetsSelectedIndexInWidget [
	presenter selectItem: 20.
	self
		assert: (presenter adapter widget selectedRowIndexes includes: 2)
]

{ #category : #'tests-widget-to-model' }
MorphicAbstractListAdapterSingleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectRowIndex: 1.
	self assert: counter equals: 1
]

{ #category : #'tests-widget-to-model' }
MorphicAbstractListAdapterSingleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection
		whenChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter adapter widget selectRowIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-widget-to-model' }
MorphicAbstractListAdapterSingleSelectionTest >> testSubscribeToEventDoesNotRaiseEvent [

	presenter selection
		whenChangedDo: [ :selection | self fail ].
]

{ #category : #'tests-widget-to-model' }
MorphicAbstractListAdapterSingleSelectionTest >> testUnselectAllInWidgetRaisesEmptySelectionChangeEvent [
	| gotSelection |
	presenter selection
		whenChangedDo: [ :selection | gotSelection := selection ].
	presenter adapter widget selectRowIndex: 0.
	self assert: gotSelection isEmpty
]

{ #category : #'tests-widget-to-model' }
MorphicAbstractListAdapterSingleSelectionTest >> testUnselectAllInWidgetRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectRowIndex: 0.
	self assert: counter equals: 1
]

{ #category : #'tests-model-to-widget' }
MorphicAbstractListAdapterSingleSelectionTest >> testUnselectPresenterIndexUnselectsIndexInWidget [
	presenter
		selectIndex: 1;
		unselectIndex: 1.
	self assert: presenter adapter widget selectedRowIndexes isEmpty
]

{ #category : #'tests-model-to-widget' }
MorphicAbstractListAdapterSingleSelectionTest >> testUnselectPresenterItemUnselectsIndexInWidget [
	presenter
		selectItem: 20;
		unselectItem: 20.
	self assert: presenter adapter widget selectedRowIndexes isEmpty
]

{ #category : #'tests-widget-to-model' }
MorphicAbstractListAdapterSingleSelectionTest >> testUnselectUnselectedWidgetIndexRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectRowIndex: 0.
	self assert: counter equals: 1
]

{ #category : #'tests-widget-to-model' }
MorphicAbstractListAdapterSingleSelectionTest >> testUnselectUnselectedWidgetIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection
		whenChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter adapter widget selectRowIndex: 0.
	self assert: selectedIndex equals: 0
]

{ #category : #'tests-widget-to-model' }
MorphicAbstractListAdapterSingleSelectionTest >> testUnselectWidgetIndexRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter adapter widget selectRowIndex: 1.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectRowIndex: 0.
	self assert: counter equals: 1
]

{ #category : #'tests-widget-to-model' }
MorphicAbstractListAdapterSingleSelectionTest >> testUnselectWidgetIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter adapter widget selectRowIndex: 1.
	presenter selection
		whenChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter adapter widget selectRowIndex: 0.
	self assert: selectedIndex equals: 0
]

{ #category : #running }
MorphicAbstractListAdapterSingleSelectionTest >> widget [

	^ self adapter widget
]
