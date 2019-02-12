Class {
	#name : #MorphicListAdapterMultipleSelectionTest,
	#superclass : #MorphicAdapterTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #running }
MorphicListAdapterMultipleSelectionTest >> adapter [

	^ presenter adapter
]

{ #category : #running }
MorphicListAdapterMultipleSelectionTest >> classToTest [
	^ ListPresenter
]

{ #category : #running }
MorphicListAdapterMultipleSelectionTest >> setUp [

	super setUp.

	window := presenter
		beMultipleSelection;
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #'tests-model-to-widget' }
MorphicListAdapterMultipleSelectionTest >> testSelectManyIndexesKeepsAllSelected [
	presenter selectIndex: 1.
	presenter selectIndex: 2.
	self
		assert: presenter adapter widget selectedIndexes asArray
		equals: #(1 2)
]

{ #category : #'tests-model-to-widget' }
MorphicListAdapterMultipleSelectionTest >> testSelectPresenterIndexOutsideRangeUnsetsSelectedIndexInWidget [
	presenter selectIndex: 100.
	self assert: presenter adapter widget selectedIndexes isEmpty
]

{ #category : #'tests-model-to-widget' }
MorphicListAdapterMultipleSelectionTest >> testSelectPresenterIndexSetsSelectedIndexInWidget [
	presenter selectIndex: 1.
	self assert: (presenter adapter widget selectedIndexes includes: 1)
]

{ #category : #'tests-model-to-widget' }
MorphicListAdapterMultipleSelectionTest >> testSelectPresenterItemSetsSelectedIndexInWidget [
	presenter selectItem: 20.
	self assert: (presenter adapter widget selectedIndexes includes: 2)
]

{ #category : #'tests-widget-to-model' }
MorphicListAdapterMultipleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectIndex: 1.
	self assert: counter equals: 1
]

{ #category : #'tests-widget-to-model' }
MorphicListAdapterMultipleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedIndex |
	presenter selection
		whenChangedDo: [ :selection | selectedIndex := selection selectedIndexes ].
	presenter adapter widget selectIndex: 1.
	self assert: (selectedIndex includes: 1)
]

{ #category : #'tests-widget-to-model' }
MorphicListAdapterMultipleSelectionTest >> testSubscribeToEventDoesNotRaiseEvent [

	presenter selection
		whenChangedDo: [ :selection | self fail ].
]

{ #category : #'tests-widget-to-model' }
MorphicListAdapterMultipleSelectionTest >> testUnselectAllInWidgetRaisesEmptySelectionChangeEvent [
	| gotSelection |
	presenter adapter widget selectIndex: 1.
	presenter selection
		whenChangedDo: [ :selection | gotSelection := selection ].
	presenter adapter widget selectIndex: 0.
	self assert: gotSelection isEmpty
]

{ #category : #'tests-widget-to-model' }
MorphicListAdapterMultipleSelectionTest >> testUnselectAllInWidgetRaisesSelectionIndexChangeEventOnce [
	| counter |
	counter := 0.
	presenter adapter widget selectIndex: 1.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	presenter adapter widget selectIndex: 0.
	self assert: counter equals: 1
]

{ #category : #running }
MorphicListAdapterMultipleSelectionTest >> widget [

	^ self adapter widget
]
