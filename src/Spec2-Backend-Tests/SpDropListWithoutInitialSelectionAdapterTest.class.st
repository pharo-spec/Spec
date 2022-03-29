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

{ #category : #tests }
SpDropListWithoutInitialSelectionAdapterTest >> testStartWithoutSelectionDoesNotTriggersChange [
	| count |

	count := 0.

	self presenter
		startWithoutSelection;
		items: #(10 20 30);
		whenSelectionChangedDo: [ count := count + 1 ].
		
	self openInstance.

	self assert: count equals: 0.	
	self presenter selectItem: 10.
	self assert: count equals: 1.
	self presenter selectItem: 20.
	self assert: count equals: 2
]
