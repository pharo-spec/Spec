Class {
	#name : #MorphicListAdapterSingleSelectionTest,
	#superclass : #SpecTestCase,
	#category : #'Spec-Tests-MorphicAdapters'
}

{ #category : #running }
MorphicListAdapterSingleSelectionTest >> adapter [

	^ presenter adapter
]

{ #category : #running }
MorphicListAdapterSingleSelectionTest >> classToTest [
	^ ListPresenter
]

{ #category : #running }
MorphicListAdapterSingleSelectionTest >> setUp [

	super setUp.

	window := presenter
		beSingleSelection;
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #'tests-model-to-widget' }
MorphicListAdapterSingleSelectionTest >> testSelectManyIndexesKeepsLastSelectionInWidget [
	presenter selectIndex: 1.
	presenter selectIndex: 2.
	self assert: presenter adapter widget selectedRowIndexes equals: #(2)
]

{ #category : #'tests-model-to-widget' }
MorphicListAdapterSingleSelectionTest >> testSelectPresenterIndexOutsideRangeUnsetsSelectedIndexInWidget [
	presenter selectIndex: 100.
	self assert: presenter adapter widget selectedRowIndexes isEmpty
]

{ #category : #'tests-model-to-widget' }
MorphicListAdapterSingleSelectionTest >> testSelectPresenterIndexSetsSelectedIndexInWidget [
	presenter selectIndex: 1.
	self
		assert: (presenter adapter widget selectedRowIndexes includes: 1)
]

{ #category : #'tests-model-to-widget' }
MorphicListAdapterSingleSelectionTest >> testSelectPresenterItemSetsSelectedIndexInWidget [
	presenter selectItem: 20.
	self
		assert: (presenter adapter widget selectedRowIndexes includes: 2)
]

{ #category : #'tests-widget-to-model' }
MorphicListAdapterSingleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectRowIndex: 1.
	self assert: counter equals: 1
]

{ #category : #'tests-widget-to-model' }
MorphicListAdapterSingleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection
		whenChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter adapter widget selectRowIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-widget-to-model' }
MorphicListAdapterSingleSelectionTest >> testSubscribeToEventDoesNotRaiseEvent [

	presenter selection
		whenChangedDo: [ :selection | self fail ].
]

{ #category : #'tests-widget-to-model' }
MorphicListAdapterSingleSelectionTest >> testUnselectAllInWidgetRaisesEmptySelectionChangeEvent [
	| gotSelection |
	presenter selection
		whenChangedDo: [ :selection | gotSelection := selection ].
	presenter adapter widget selectRowIndex: 0.
	self assert: gotSelection isEmpty
]

{ #category : #'tests-widget-to-model' }
MorphicListAdapterSingleSelectionTest >> testUnselectAllInWidgetRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectRowIndex: 0.
	self assert: counter equals: 1
]

{ #category : #running }
MorphicListAdapterSingleSelectionTest >> widget [

	^ self adapter widget
]
