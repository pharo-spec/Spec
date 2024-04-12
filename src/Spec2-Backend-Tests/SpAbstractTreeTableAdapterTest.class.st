Class {
	#name : 'SpAbstractTreeTableAdapterTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'testing' }
SpAbstractTreeTableAdapterTest class >> isAbstract [ 
	
	^ self = SpAbstractTreeTableAdapterTest
]

{ #category : 'accessing' }
SpAbstractTreeTableAdapterTest >> classToTest [

	^ SpTreeTablePresenter 
]

{ #category : 'initialization' }
SpAbstractTreeTableAdapterTest >> initializeTestedInstance [
	presenter
		addColumn: (SpStringTableColumn title: 'Value' evaluated: #printString);
		hideColumnHeaders;
		roots: #(1 2 3);
		children: [ :aNumber | {(aNumber * 2) . (aNumber * 3) . (aNumber * 10)} ]
]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testAfterOpeningEmptyLazyChildrenExpandIconVanish [
	presenter
		children: [ :aNumber | aNumber odd ifTrue: [ {(aNumber * 2) . (aNumber * 3) . (aNumber * 10)} ] ifFalse: [ #() ] ];
		lazilyComputeChildren.

	self
		assert: (self adapter isRowMorphExpandableAt: 2)
		description: 'If we do not compute the children then we should show an expand icon even if there is no children'.

	self adapter expandRowAt: 2.	"This row has no child"

	self deny: (self adapter isRowMorphExpandableAt: 2)
]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testChangingRootsResetsSelection [

	self presenter selection selectPath: #(2 3).
	self presenter roots: #(10 11 12).
	
	self assert: self adapter selectedItem equals: nil

]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testChangingRootsUpdateWidget [

	self presenter roots: #(10 11 12).
	
	backendForTest assertList: self adapter displayItems: #('10' '11' '12').
	

]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testItemsWithoutChildrenDoNotHaveExpandIcon [
	presenter children: [ :aNumber | aNumber odd ifTrue: [ {(aNumber * 2) . (aNumber * 3) . (aNumber * 10)} ] ifFalse: [ #() ] ].

	self assert: (self adapter isRowMorphExpandableAt: 1).
	self deny: (self adapter isRowMorphExpandableAt: 2).
	self assert: (self adapter isRowMorphExpandableAt: 3)
]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testLazilyComputeChildrenDoesNotComputeChildren [
	presenter
		children: [ :aNumber | aNumber odd ifTrue: [ {(aNumber * 2) . (aNumber * 3) . (aNumber * 10)} ] ifFalse: [ #() ] ];
		lazilyComputeChildren.

	self assert: (self adapter isRowMorphExpandableAt: 1).
	self
		assert: (self adapter isRowMorphExpandableAt: 2)
		description: 'If we do not compute the children then we should show an expand icon even if there is no children'.
	self assert: (self adapter isRowMorphExpandableAt: 3)
]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testRightClickShowsMenu [
	| menu |

	presenter contextMenu: (menu := SpMockMenuPresenter new).
	self deny: menu shown.
	self emulateRightClick.
	self assert: menu shown
]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testSelectItemRaiseEvent [

	| called |
	
	self presenter whenSelectionChangedDo: [ called := true ].
	self presenter selection selectPath: #(2 3).

	self assert: called equals: true
]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testSelectItemSelectsTheGivenElement [

	self presenter selection selectPath: #(2).
	self assert: self adapter selectedItem equals: 2.
]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testSelectItemSelectsTheGivenElementAndExpandsTheBranches [

	self presenter selection selectPath: #(2 3).
	self assert: self adapter selectedItem equals: 20.
]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testSelectingAPathUpdatesSelectionInPresenter [

	self presenter selection selectPath: #(2 3).
	self assert: self presenter selectedItem equals: 20.
]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testSelectingOutOfRangeKeepOldSelection [
	
	self presenter selection selectPath: #(2 3).
	self presenter selection selectPath: #(7 3).
	self assert: self adapter selectedItem equals: 20

]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testShowingColumnDisplayColumn [

	self presenter showColumnHeaders.
	
	backendForTest assertHasHeader: self adapter
]

{ #category : 'tests' }
SpAbstractTreeTableAdapterTest >> testStartsWithoutSelection [

	self assert: self adapter selectedItem equals: nil.
]
