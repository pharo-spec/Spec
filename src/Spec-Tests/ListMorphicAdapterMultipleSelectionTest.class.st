Class {
	#name : #ListMorphicAdapterMultipleSelectionTest,
	#superclass : #SpecTestCase,
	#category : #'Spec-Tests-MorphicAdapters'
}

{ #category : #running }
ListMorphicAdapterMultipleSelectionTest >> adapter [

	^ presenter adapter
]

{ #category : #running }
ListMorphicAdapterMultipleSelectionTest >> classToTest [
	^ ListPresenter
]

{ #category : #running }
ListMorphicAdapterMultipleSelectionTest >> setUp [

	super setUp.

	window := presenter
		beMultipleSelection;
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterMultipleSelectionTest >> testSelectManyIndexesKeepsAllSelected [
	presenter selectIndex: 1.
	presenter selectIndex: 2.
	self assert: presenter adapter widget selectedRowIndexes equals: #(1 2)
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterMultipleSelectionTest >> testSelectPresenterIndexOutsideRangeUnsetsSelectedIndexInWidget [
	presenter selectIndex: 100.
	self assert: presenter adapter widget selectedRowIndexes isEmpty
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterMultipleSelectionTest >> testSelectPresenterIndexSetsSelectedIndexInWidget [
	presenter selectIndex: 1.
	self
		assert: (presenter adapter widget selectedRowIndexes includes: 1)
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterMultipleSelectionTest >> testSelectPresenterItemSetsSelectedIndexInWidget [
	presenter selectItem: 20.
	self
		assert: (presenter adapter widget selectedRowIndexes includes: 2)
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterMultipleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectRowIndex: 1.
	self assert: counter equals: 1
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterMultipleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection
		whenChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter adapter widget selectRowIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterMultipleSelectionTest >> testSubscribeToEventDoesNotRaiseEvent [

	presenter selection
		whenChangedDo: [ :selection | self fail ].
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterMultipleSelectionTest >> testUnselectAllInWidgetRaisesEmptySelectionChangeEvent [
	| gotSelection |
	presenter selection
		whenChangedDo: [ :selection | gotSelection := selection ].
	presenter adapter widget selectRowIndex: 0.
	self assert: gotSelection isEmpty
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterMultipleSelectionTest >> testUnselectAllInWidgetRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectRowIndex: 0.
	self assert: counter equals: 1
]

{ #category : #running }
ListMorphicAdapterMultipleSelectionTest >> widget [

	^ self adapter widget
]
