Class {
	#name : #TreeSingleSelectionMode,
	#superclass : #AbstractTreeSingleSelectionMode,
	#category : #'Spec-Core-Widgets-Tree'
}

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
