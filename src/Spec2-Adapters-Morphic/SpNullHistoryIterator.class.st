"
A history iterator to be used when disabling undo/redo
"
Class {
	#name : 'SpNullHistoryIterator',
	#superclass : 'HistoryIterator',
	#category : 'Spec2-Adapters-Morphic-Support',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Support'
}

{ #category : 'adding' }
SpNullHistoryIterator >> addItem: aHistoryItem [
	"do nothing"
]

{ #category : 'adding' }
SpNullHistoryIterator >> at: anInteger put: anItem [
	"do nothing"
]
