Class {
	#name : #TreeMultipleSelectionMode,
	#superclass : #AbstractTreeSingleSelectionMode,
	#category : #'Spec-Core-Widgets-Tree'
}

{ #category : #accessing }
TreeMultipleSelectionMode >> presenter: aTreeTablePresenter [ 

	presenter := aTreeTablePresenter 
]

{ #category : #selection }
TreeMultipleSelectionMode >> replaceOtherSelectionMode: anotherSelectionMode [

	| originalValueHolder |

	selection := anotherSelectionMode selectedPath.
	originalValueHolder := anotherSelectionMode observablePropertyNamed: #selection.
	
	originalValueHolder announcer subscriptions subscriptions do: [ 
		self halt.	
	]
]

{ #category : #accessing }
TreeMultipleSelectionMode >> selectedItem [
	self shouldBeImplemented.
]

{ #category : #selection }
TreeMultipleSelectionMode >> selectedPath: aPath [ 
	
	(selection includes: aPath) ifTrue: [ ^ self ].
	
	selection := selection copyWith: aPath.
]

{ #category : #accessing }
TreeMultipleSelectionMode >> selectedPaths [
	^ selection
]
