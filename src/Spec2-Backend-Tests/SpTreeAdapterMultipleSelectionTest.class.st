Class {
	#name : 'SpTreeAdapterMultipleSelectionTest',
	#superclass : 'SpAbstractListAdapterMultipleSelectionTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpTreeAdapterMultipleSelectionTest >> classToTest [

	^ SpTreePresenter
]

{ #category : 'initialization' }
SpTreeAdapterMultipleSelectionTest >> initializeTestedInstance [ 

	presenter
		beMultipleSelection;
		roots: #(10 20 30 'abc')
]

{ #category : 'tests - model-to-widget' }
SpTreeAdapterMultipleSelectionTest >> testClickDoesNotAccumulatesSelection [
	
	self openInstance.
	presenter adapter sendClickEventToRowAtPath: #(1).
	presenter adapter sendClickEventToRowAtPath: #(2).
	self
		assert: self adapter selectedPaths
		equals: #((2))
]

{ #category : 'tests - model-to-widget' }
SpTreeAdapterMultipleSelectionTest >> testSelectManyIndexesKeepsAllSelected [
	
	presenter selectPath: #(1).
	presenter selectPath: #(2).
	self
		assert: self adapter selectedPaths
		equals: #((1) (2))
]

{ #category : 'tests - model-to-widget' }
SpTreeAdapterMultipleSelectionTest >> testSelectPresenterIndexOutsideRangeUnsetsSelectedIndexInWidget [
	
	presenter selectPath: #(100).
	self assert: self adapter selectedPaths isEmpty
]

{ #category : 'tests - model-to-widget' }
SpTreeAdapterMultipleSelectionTest >> testSelectPresenterIndexSetsSelectedIndexInWidget [
	
	presenter selectPath: #(1).
	self assert: (self adapter selectedPaths includes: #(1))
]

{ #category : 'tests - model-to-widget' }
SpTreeAdapterMultipleSelectionTest >> testSelectPresenterItemSetsSelectedIndexInWidget [
	"There is no selectedIndex in trees (but selectedPath).
	 This cancels superclass method"
	
	self skip
]

{ #category : 'tests - model-to-widget' }
SpTreeAdapterMultipleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventOnce [
	| counter |
	
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	self adapter selectPath: #(1).
	self assert: counter equals: 1
]

{ #category : 'tests - model-to-widget' }
SpTreeAdapterMultipleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedPaths |
	
	presenter selection whenChangedDo: [ :selection | selectedPaths := selection ].
	self adapter selectPath: #(1).
	self assert: (selectedPaths includes: #(1))
]

{ #category : 'tests - model-to-widget' }
SpTreeAdapterMultipleSelectionTest >> testShiftClicktAccumulatesSelection [
	
	self openInstance.
	presenter adapter sendClickWithShiftEventToRowAtPath: #(1).
	presenter adapter sendClickWithShiftEventToRowAtPath: #(2).
	self
		assert: self adapter selectedPaths
		equals: #((2) (1))
]

{ #category : 'tests' }
SpTreeAdapterMultipleSelectionTest >> testUnselectAllInWidgetRaisesEmptySelectionChangeEvent [
	| gotSelection |
	
	self adapter selectPath: #(1).
	presenter selection
		whenChangedDo: [ :selection | gotSelection := selection ].
	self adapter selectPath: #().
	self assertEmpty: gotSelection
]

{ #category : 'tests - widget-to-model' }
SpTreeAdapterMultipleSelectionTest >> testUnselectAllInWidgetRaisesSelectionIndexChangeEventOnce [
	| counter |
	
	counter := 0.
	self adapter selectPath: #(1).
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	self adapter selectPath: #().
	self assert: counter equals: 1
]
