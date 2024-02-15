"
A SpChooserPresenterTest is a test class for testing the behavior of SpChooserPresenter
"
Class {
	#name : 'SpChooserPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'chooserPresenter'
	],
	#category : 'Spec2-CommonWidgets-Tests-Core',
	#package : 'Spec2-CommonWidgets-Tests',
	#tag : 'Core'
}

{ #category : 'running' }
SpChooserPresenterTest >> initializeChooser [

	chooserPresenter := SpChooserPresenter
		                    sourceItems: self items
		                    displayBlock: #name
]

{ #category : 'running' }
SpChooserPresenterTest >> items [

	^ RBBrowserEnvironment default allClasses
]

{ #category : 'running' }
SpChooserPresenterTest >> setUp [

	super setUp.
	self initializeChooser
]

{ #category : 'tests' }
SpChooserPresenterTest >> testAddAll [

	self assert: chooserPresenter sourceList unfilteredItems isNotEmpty.
	self assert: chooserPresenter targetList unfilteredItems isEmpty.
	chooserPresenter addAll.
	self assert: chooserPresenter sourceList unfilteredItems isEmpty.
	self assert: chooserPresenter targetList unfilteredItems isNotEmpty
]

{ #category : 'tests' }
SpChooserPresenterTest >> testAddAllOfFiltered [

	| sourceItemsToAdd sourceItems targetItems allItems presenter |
	sourceItemsToAdd := #( ToAdd1 ToAdd2 ).
	sourceItems := { 'S1' } , sourceItemsToAdd.
	targetItems := { 'T1'. 'T2' }.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	presenter sourceList filterInputPresenter text: 'ToAdd'.

	self
		assertCollection: presenter sourceList items
		hasSameElements: sourceItemsToAdd.
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList items
		hasSameElements: targetItems.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter addAll.

	self
		assert: presenter sourceList filterInputPresenter text
		equals: ''.
	self
		assertCollection: presenter sourceList items
		hasSameElements: sourceItems \ sourceItemsToAdd.
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems \ sourceItemsToAdd
]

{ #category : 'tests' }
SpChooserPresenterTest >> testAddItemUsingFilter [

chooserPresenter sourceList applyFilter: 'HashedCollection'.
	chooserPresenter addAll.
	self
		assert: chooserPresenter sourceList unfilteredItems size
		equals: self items size - 3.
	self
		assertCollection: chooserPresenter targetList unfilteredItems
		hasSameElements: { 
				FLHashedCollectionSerializationTest.
				FLLargeIdentityHashedCollection.
				HashedCollection }
]

{ #category : 'tests' }
SpChooserPresenterTest >> testAddSelected [

	self assert: chooserPresenter sourceList selectedItems isEmpty.
	chooserPresenter sourceList selectItem:
		chooserPresenter sourceList unfilteredItems first.
	chooserPresenter addSelected.
	self
		assert: chooserPresenter targetList unfilteredItems size
		equals: 1.
	self
		assert: chooserPresenter sourceList unfilteredItems size
		equals: self items size - 1
]

{ #category : 'tests' }
SpChooserPresenterTest >> testAddSelectedAllOfFiltered [

	| sourceItemsToAdd sourceItems targetItems allItems presenter |
	sourceItemsToAdd := #( ToAdd1 ToAdd2 ).
	sourceItems := { 'S1' } , sourceItemsToAdd.
	targetItems := { 'T1'. 'T2' }.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	presenter sourceList filterInputPresenter text: 'ToAdd'.

	self
		assertCollection: presenter sourceList items
		hasSameElements: sourceItemsToAdd.
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList items
		hasSameElements: targetItems.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter sourceList selectItems: sourceItemsToAdd.
	presenter addSelected.

	self
		assert: presenter sourceList filterInputPresenter text
		equals: ''.
	self
		assertCollection: presenter sourceList items
		hasSameElements: sourceItems \ sourceItemsToAdd.
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems \ sourceItemsToAdd
]

{ #category : 'tests' }
SpChooserPresenterTest >> testAddSelectedPartOfFiltered [

	| sourceItemToAdd sourceItems targetItems allItems presenter |
	sourceItemToAdd := 'ToAdd'.
	sourceItems := {
		               'S1'.
		               'ToNotAdd'.
		               sourceItemToAdd }.
	targetItems := { 'T1'. 'T2' }.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	presenter sourceList filterInputPresenter text: 'To'.

	self
		assertCollection: presenter sourceList items
		hasSameElements: #( ToAdd ToNotAdd ).
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList items
		hasSameElements: targetItems.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter sourceList selectItem: sourceItemToAdd.
	presenter addSelected.

	self
		assert: presenter sourceList filterInputPresenter text
		equals: 'To'.
	self
		assertCollection: presenter sourceList items
		hasSameElements: { 'ToNotAdd' }.
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: (sourceItems copyWithout: sourceItemToAdd)
]

{ #category : 'tests' }
SpChooserPresenterTest >> testAllRemoveThenAdd [

	| targetItemToRemove sourceItemToAdd sourceItems targetItems allItems presenter |
	targetItemToRemove := 'TargetToRemove'.
	sourceItemToAdd := 'SourceToAdd'.
	sourceItems := {
		               'S1'.
		               'S2'.
		               sourceItemToAdd }.
	targetItems := {
		               'T1'.
		               'T2'.
		               targetItemToRemove }.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter targetList selectItem: targetItemToRemove.
	presenter removeAll.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: allItems.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: #(  ).

	presenter sourceList selectItem: sourceItemToAdd.
	presenter addAll.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: #(  ).
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: allItems
]

{ #category : 'tests' }
SpChooserPresenterTest >> testFilterBothThenRemove [

	| targetItemToRemove sourceItemToAdd sourceItems targetItems allItems presenter |
	targetItemToRemove := 'TargetToRemove'.
	sourceItemToAdd := 'SourceToAdd'.
	sourceItems := {
		               'S1'.
		               'S2'.
		               sourceItemToAdd }.
	targetItems := {
		               'T1'.
		               'T2'.
		               targetItemToRemove }.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter sourceList filterInputPresenter text: 'ToAdd'.
	presenter targetList filterInputPresenter text: 'ToRemove'.


	self
		assertCollection: presenter sourceList items
		hasSameElements: { sourceItemToAdd }.
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList items
		hasSameElements: { targetItemToRemove }.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter removeAll.

	self
		assert: presenter sourceList filterInputPresenter text
		equals: 'ToAdd'.
	self
		assert: presenter targetList filterInputPresenter text
		equals: ''.
	self
		assertCollection: presenter sourceList items
		hasSameElements: { sourceItemToAdd }.
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems , { targetItemToRemove }.
	self
		assertCollection: presenter targetList items
		hasSameElements: (targetItems copyWithout: targetItemToRemove).
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: (targetItems copyWithout: targetItemToRemove)
]

{ #category : 'tests' }
SpChooserPresenterTest >> testFilteredRemoveThenAdd [

	| targetItemToRemove sourceItemToAdd sourceItems targetItems allItems presenter |
	targetItemToRemove := 'TargetToRemove'.
	sourceItemToAdd := 'SourceToAdd'.
	sourceItems := {
		               'S1'.
		               'S2'.
		               sourceItemToAdd }.
	targetItems := {
		               'T1'.
		               'T2'.
		               targetItemToRemove }.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter targetList filterInputPresenter text: 'ToRemove'.
	presenter removeAll.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems , { targetItemToRemove }.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: (targetItems copyWithout: targetItemToRemove).

	presenter sourceList filterInputPresenter text: 'ToAdd'.
	presenter addAll.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements:
		(sourceItems copyWithout: sourceItemToAdd) , { targetItemToRemove }.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements:
		(targetItems copyWithout: targetItemToRemove) , { sourceItemToAdd }
]

{ #category : 'tests' }
SpChooserPresenterTest >> testRemoveAll [

	chooserPresenter removeAll.
	self assert: chooserPresenter sourceList unfilteredItems isNotEmpty.
	self assert: chooserPresenter targetList unfilteredItems isEmpty
]

{ #category : 'tests' }
SpChooserPresenterTest >> testRemoveAllOfFiltered [

	| targetItemsToRemove sourceItems targetItems allItems presenter |
	targetItemsToRemove := #( ToRemove1 ToRemove2 ).
	sourceItems := { 'S1'. 'S2' }.
	targetItems := { 'T1' } , targetItemsToRemove.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	presenter targetList filterInputPresenter text: 'ToRemove'.

	self
		assertCollection: presenter sourceList items
		hasSameElements: sourceItems.
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList items
		hasSameElements: targetItemsToRemove.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter removeAll.

	self
		assert: presenter targetList filterInputPresenter text
		equals: ''.
	self
		assertCollection: presenter targetList items
		hasSameElements: targetItems \ targetItemsToRemove.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems \ targetItemsToRemove
]

{ #category : 'tests' }
SpChooserPresenterTest >> testRemoveItemUsingFilter [

	chooserPresenter addAll.
	chooserPresenter targetList applyFilter: 'HashedCollection'.
	chooserPresenter removeAll.
	self
		assert: chooserPresenter targetList unfilteredItems size
		equals: self items size - 3.
	self
		assertCollection: chooserPresenter sourceList unfilteredItems
		hasSameElements: { 
				FLHashedCollectionSerializationTest.
				FLLargeIdentityHashedCollection.
				HashedCollection }
]

{ #category : 'tests' }
SpChooserPresenterTest >> testRemoveSelected [

	chooserPresenter addAll.
	chooserPresenter targetList selectItem:
		chooserPresenter targetList unfilteredItems first.
	chooserPresenter removeSelected.
	self
		assert: chooserPresenter sourceList unfilteredItems size
		equals: 1.
	self
		assert: chooserPresenter targetList unfilteredItems size
		equals: self items size - 1
]

{ #category : 'tests' }
SpChooserPresenterTest >> testRemoveSelectedAllOfFiltered [

	| targetItemsToRemove sourceItems targetItems allItems presenter |
	targetItemsToRemove := #( ToRemove1 ToRemove2 ).
	sourceItems := { 'S1'. 'S2' }.
	targetItems := { 'T1' } , targetItemsToRemove.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	presenter targetList filterInputPresenter text: 'ToRemove'.

	self
		assertCollection: presenter sourceList items
		hasSameElements: sourceItems.
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList items
		hasSameElements: targetItemsToRemove.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter targetList selectItems: targetItemsToRemove.
	presenter removeSelected.

	self
		assert: presenter targetList filterInputPresenter text
		equals: ''.
	self
		assertCollection: presenter targetList items
		hasSameElements: targetItems \ targetItemsToRemove.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems \ targetItemsToRemove
]

{ #category : 'tests' }
SpChooserPresenterTest >> testRemoveSelectedPartOfFiltered [

	| targetItemToRemove sourceItems targetItems allItems presenter |
	targetItemToRemove := 'ToRemove'.
	sourceItems := { 'S1'. 'S2' }.
	targetItems := {
		               'T1'.
		               'ToNotRemove'.
		               targetItemToRemove }.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	presenter targetList filterInputPresenter text: 'To'.

	self
		assertCollection: presenter sourceList items
		hasSameElements: sourceItems.
	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList items
		hasSameElements: #( ToNotRemove ToRemove ).
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter targetList selectItem: targetItemToRemove.
	presenter removeSelected.

	self
		assert: presenter targetList filterInputPresenter text
		equals: 'To'.
	self
		assertCollection: presenter targetList items
		hasSameElements: #( ToNotRemove ).
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: (targetItems copyWithout: targetItemToRemove)
]

{ #category : 'tests' }
SpChooserPresenterTest >> testSelectedAddThenRemove [

	| targetItemToRemove sourceItemToAdd sourceItems targetItems allItems presenter |
	targetItemToRemove := 'TargetToRemove'.
	sourceItemToAdd := 'SourceToAdd'.
	sourceItems := {
		               'S1'.
		               'S2'.
		               sourceItemToAdd }.
	targetItems := {
		               'T1'.
		               'T2'.
		               targetItemToRemove }.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter sourceList selectItem: sourceItemToAdd.
	presenter addSelected.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: (sourceItems copyWithout: sourceItemToAdd).
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems , { sourceItemToAdd }.

	presenter targetList selectItem: targetItemToRemove.
	presenter removeSelected.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements:
		(sourceItems copyWithout: sourceItemToAdd) , { targetItemToRemove }.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements:
		(targetItems copyWithout: targetItemToRemove) , { sourceItemToAdd }
]

{ #category : 'tests' }
SpChooserPresenterTest >> testSelectedRemoveThenAdd [

	| targetItemToRemove sourceItemToAdd sourceItems targetItems allItems presenter |
	targetItemToRemove := 'TargetToRemove'.
	sourceItemToAdd := 'SourceToAdd'.
	sourceItems := {
		               'S1'.
		               'S2'.
		               sourceItemToAdd }.
	targetItems := {
		               'T1'.
		               'T2'.
		               targetItemToRemove }.
	allItems := sourceItems , targetItems.

	presenter := SpChooserPresenter
		             sourceItems: sourceItems copy
		             chosenItems: targetItems copy.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: targetItems.

	presenter targetList selectItem: targetItemToRemove.
	presenter removeSelected.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements: sourceItems , { targetItemToRemove }.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements: (targetItems copyWithout: targetItemToRemove).

	presenter sourceList selectItem: sourceItemToAdd.
	presenter addSelected.

	self
		assertCollection: presenter sourceList unfilteredItems
		hasSameElements:
		(sourceItems copyWithout: sourceItemToAdd) , { targetItemToRemove }.
	self
		assertCollection: presenter targetList unfilteredItems
		hasSameElements:
		(targetItems copyWithout: targetItemToRemove) , { sourceItemToAdd }
]

{ #category : 'tests' }
SpChooserPresenterTest >> testSourceLabel [

	self
		assert: chooserPresenter sourceLabel
		equals: chooserPresenter class defaultSourceLabel.

	chooserPresenter sourceLabel: 'new source label'.

	self assert: chooserPresenter sourceLabel equals: 'new source label'
]

{ #category : 'tests' }
SpChooserPresenterTest >> testTargetLabel [

	self
		assert: chooserPresenter targetLabel
		equals: chooserPresenter class defaultTargetLabel.

	chooserPresenter targetLabel: 'new target label'.

	self assert: chooserPresenter targetLabel equals: 'new target label'
]
