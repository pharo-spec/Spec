Class {
	#name : #TreeTableAdapterSingleColumnTest,
	#superclass : #AbstractTreeTableAdapterTest,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
TreeTableAdapterSingleColumnTest >> initializeTestedInstance [ 

	presenter
		addColumn: (StringTableColumn new 
			evaluated: #printString;
			yourself);	
		roots: #(1 2 3);
		children: [ :aNumber | { aNumber * 2. aNumber * 3. aNumber * 10 } ].

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
TreeTableAdapterSingleColumnTest >> testStartsWithoutSelection [

	self assert: self adapter selectedItem equals: nil.
]
