Class {
	#name : #TreeSingleSelectionMode,
	#superclass : #AbstractTreeSingleSelectionMode,
	#category : #'Spec-Core-Widgets-Tree'
}

{ #category : #accessing }
TreeSingleSelectionMode >> presenter: aTreeTablePresenter [ 

	presenter := aTreeTablePresenter
]

{ #category : #accessing }
TreeSingleSelectionMode >> selectedItem [
	
	selection ifEmpty: [ ^ nil ].
	
	^ presenter itemAtPath: selection.
]

{ #category : #accessing }
TreeSingleSelectionMode >> selectedPath [
	
	^ selection
]

{ #category : #accessing }
TreeSingleSelectionMode >> selectedPath: aPath [
	
	selection := aPath.

]

{ #category : #accessing }
TreeSingleSelectionMode >> selectedPaths [
	
	selection ifEmpty: [ ^ #() ].
	
	^ { selection }
]
