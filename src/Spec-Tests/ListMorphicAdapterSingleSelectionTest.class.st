Class {
	#name : #ListMorphicAdapterSingleSelectionTest,
	#superclass : #SpecTestCase,
	#category : #'Spec-Tests-MorphicAdapters'
}

{ #category : #running }
ListMorphicAdapterSingleSelectionTest >> adapter [

	^ presenter adapter
]

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

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterSingleSelectionTest >> testSelectManyIndexesKeepsLastSelectionInWidget [
	presenter selectIndex: 1.
	presenter selectIndex: 2.
	self assert: presenter adapter widget selectedRowIndexes equals: #(2)
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterSingleSelectionTest >> testSelectPresenterIndexOutsideRangeUnsetsSelectedIndexInWidget [
	presenter selectIndex: 100.
	self assert: presenter adapter widget selectedRowIndexes isEmpty
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterSingleSelectionTest >> testSelectPresenterIndexSetsSelectedIndexInWidget [
	presenter selectIndex: 1.
	self
		assert: (presenter adapter widget selectedRowIndexes includes: 1)
]

{ #category : #'tests-model-to-widget' }
ListMorphicAdapterSingleSelectionTest >> testSelectPresenterItemSetsSelectedIndexInWidget [
	presenter selectItem: 20.
	self
		assert: (presenter adapter widget selectedRowIndexes includes: 2)
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterSingleSelectionTest >> testSetWidgetSelectIndexRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectRowIndex: 1.
	self assert: counter equals: 1
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterSingleSelectionTest >> testSetWidgetSelectIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection
		whenChangedDo: [ :selection | selectedIndex := selection selectedIndex ].
	presenter adapter widget selectRowIndex: 1.
	self assert: selectedIndex equals: 1
]

{ #category : #'tests-widget-to-model' }
ListMorphicAdapterSingleSelectionTest >> testSubscribeToEventDoesNotRaiseEvent [

	presenter selection
		whenChangedDo: [ :selection | self fail ].
]

{ #category : #running }
ListMorphicAdapterSingleSelectionTest >> widget [

	^ self adapter widget
]
