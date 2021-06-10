Class {
	#name : #SpDropListWithoutInitialSelectionAdapterTest,
	#superclass : #SpDropListAdapterTest,
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #initialization }
SpDropListWithoutInitialSelectionAdapterTest >> initializeTestedInstance [ 

	presenter startWithoutSelection.	
	super initializeTestedInstance.

]

{ #category : #tests }
SpDropListWithoutInitialSelectionAdapterTest >> testAddingAnItemSelectsItIfThereIsNone [

	self presenter addItemLabeled: 40 do: [].

	self assert: self presenter selectedItem equals: 40.
	self assert: self adapter selectedIndexes equals: #(4).
	
]

{ #category : #tests }
SpDropListWithoutInitialSelectionAdapterTest >> testSelectionStartsEmptyIfStartWithoutSelectionIsSet [

	self assert: self presenter selectedItem equals: nil.
	self assert: self adapter selectedIndexes equals: #().
	
]
