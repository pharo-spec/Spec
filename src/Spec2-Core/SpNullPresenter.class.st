"
A null presenter that contains nothing.
Used by DynamicPresentersListBuilder to fill empty space when required for the layout.
"
Class {
	#name : #SpNullPresenter,
	#superclass : #SpComposablePresenter,
	#category : #'Spec2-Core-Widgets'
}

{ #category : #specs }
SpNullPresenter class >> defaultSpec [
	"Returns empty layout. That's the point of null presenter."
	^ SpLayout composed
]

{ #category : #initialization }
SpNullPresenter >> initializeWidgets [
	"Does nothing. That's the point of null presenter."
]
