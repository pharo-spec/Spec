Class {
	#name : #TreeTableAdapterSingleColumnTest,
	#superclass : #AbstractTreeTableAdapterTest,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
TreeTableAdapterSingleColumnTest >> initializeTestedInstance [ 

	presenter
		addColumn: (StringTableColumn title: 'Value' evaluated: #printString);
		hideColumnHeaders;	
		roots: #(1 2 3);
		children: [ :aNumber | { aNumber * 2. aNumber * 3. aNumber * 10 } ].

]

{ #category : #running }
TreeTableAdapterSingleColumnTest >> testChangingRootsResetsSelection [

	self presenter selection selectedPath: #(2 3).
	self presenter roots: #(10 11 12).
	
	self assert: self adapter selectedItem equals: nil

]

{ #category : #running }
TreeTableAdapterSingleColumnTest >> testChangingRootsUpdateWidget [

	self presenter roots: #(10 11 12).
	
	backendForTest assertList: self adapter widget displayItems: #('10' '11' '12').
	

]

{ #category : #running }
TreeTableAdapterSingleColumnTest >> testSelectItemRaiseEvent [

	| called |
	
	self presenter whenSelectionChangedDo: [ called := true ].
	self presenter selection selectedPath: #(2 3).

	self assert: called equals: true
]

{ #category : #running }
TreeTableAdapterSingleColumnTest >> testSelectItemSelectsTheGivenElement [

	self presenter selection selectedPath: #(2).

	self assert: self adapter selectedItem equals: 2.
]

{ #category : #running }
TreeTableAdapterSingleColumnTest >> testSelectItemSelectsTheGivenElementAndExpandsTheBranches [

	self presenter selection selectedPath: #(2 3).

	self assert: self adapter selectedItem equals: 20.
]

{ #category : #running }
TreeTableAdapterSingleColumnTest >> testSelectingOutOfRangeResetsSelection [

	self presenter selection selectedPath: #(2 3).
	self presenter selection selectedPath: #(7 3).
	
	self assert: self adapter selectedItem equals: nil

]

{ #category : #running }
TreeTableAdapterSingleColumnTest >> testShowingColumnDisplayColumn [

	self presenter showColumnHeaders.
	
	backendForTest assertHasHeader: self adapter widget
]

{ #category : #running }
TreeTableAdapterSingleColumnTest >> testStartsWithoutSelection [

	self assert: self adapter selectedItem equals: nil.
]
