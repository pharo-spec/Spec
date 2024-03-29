Class {
	#name : 'SpTreeTableAdapterMultipleSelectionTest',
	#superclass : 'SpAbstractListAdapterMultipleSelectionTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpTreeTableAdapterMultipleSelectionTest >> classToTest [

	^ SpTreeTablePresenter
]

{ #category : 'initialization' }
SpTreeTableAdapterMultipleSelectionTest >> initializeTestedInstance [ 

	presenter
		beMultipleSelection;
		addColumn: (SpStringTableColumn title: 'Test' evaluated: #asString);
		roots: #(10 20 30 'abc')
]

{ #category : 'tests - model-to-widget' }
SpTreeTableAdapterMultipleSelectionTest >> testSelectManyIndexesKeepsAllSelected [
	
	presenter selectPath: #(1).
	presenter selectPath: #(2).
	self
		assert: self adapter selectedPaths
		equals: #((1) (2))
]

{ #category : 'tests - model-to-widget' }
SpTreeTableAdapterMultipleSelectionTest >> testSelectPresenterIndexOutsideRangeUnsetsSelectedIndexInWidget [
	
	presenter selectPath: #(100).
	self assert: self adapter selectedPaths isEmpty
]

{ #category : 'tests - model-to-widget' }
SpTreeTableAdapterMultipleSelectionTest >> testSelectPresenterIndexSetsSelectedIndexInWidget [
	
	presenter selectPath: #(1).
	self assert: (self adapter selectedPaths includes: #(1))
]

{ #category : 'tests - model-to-widget' }
SpTreeTableAdapterMultipleSelectionTest >> testSelectPresenterItemSetsSelectedIndexInWidget [
	"There is no selectedIndex in trees (but selectedPath).
	 This cancels superclass method"
	
	self skip
]

{ #category : 'tests - model-to-widget' }
SpTreeTableAdapterMultipleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventOnce [
	| counter |
	
	counter := 0.
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	self adapter selectPath: #(1).
	self assert: counter equals: 1
]

{ #category : 'tests - model-to-widget' }
SpTreeTableAdapterMultipleSelectionTest >> testSelectWidgetIndexRaisesSelectionIndexChangeEventWithSelectedIndex [
	| selectedPaths |
	
	presenter selection whenChangedDo: [ :selection | selectedPaths := selection ].
	self adapter selectPath: #(1).
	self assert: (selectedPaths includes: #(1))
]

{ #category : 'tests' }
SpTreeTableAdapterMultipleSelectionTest >> testUnselectAllInWidgetRaisesEmptySelectionChangeEvent [
	| gotSelection |
	
	self adapter selectPath: #(1).
	presenter selection
		whenChangedDo: [ :selection | gotSelection := selection ].
	self adapter selectPath: #().
	self assertEmpty: gotSelection
]

{ #category : 'tests - widget-to-model' }
SpTreeTableAdapterMultipleSelectionTest >> testUnselectAllInWidgetRaisesSelectionIndexChangeEventOnce [
	| counter |
	
	counter := 0.
	self adapter selectPath: #(1).
	presenter selection
		whenChangedDo: [ :selection | counter := counter + 1 ].
	self adapter selectPath: #().
	self assert: counter equals: 1
]
