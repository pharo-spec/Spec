Class {
	#name : 'SpTreeTableAdapterSingleColumnMultiSelectionTest',
	#superclass : 'SpAbstractTreeTableAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'initialization' }
SpTreeTableAdapterSingleColumnMultiSelectionTest >> initializeTestedInstance [
	super initializeTestedInstance.
	presenter beMultipleSelection
]

{ #category : 'tests' }
SpTreeTableAdapterSingleColumnMultiSelectionTest >> testSelecting2ElementsUpdatesThePresenterCorrectly [


]

{ #category : 'tests' }
SpTreeTableAdapterSingleColumnMultiSelectionTest >> testSelectingAPathUpdatesSelectionInPresenter [

	self presenter selection 
		selectPath: #(1 2);
		selectPath: #(2 3).
		
	self assert: self adapter selectedPaths asArray equals: #(#(1 2) (2 3))
]
