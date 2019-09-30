"
I'm a node used by the SpTreeBreadthFirstSearch alogorithm.
I remember the parent path to the items I hold.
I do not hold one item but rather the whole list of children of an item. It allows to easily search an item in the list and know its index in the list (used to compute the path to the element).
"
Class {
	#name : #SpTreeBFSNode,
	#superclass : #Object,
	#instVars : [
		'parentPath',
		'items'
	],
	#category : #'Spec2-Core-Widgets-Tree'
}

{ #category : #'instance creation' }
SpTreeBFSNode class >> items: anItemList [
	^ self new 
		items: anItemList;
		yourself
]

{ #category : #iterating }
SpTreeBFSNode >> collectWithIndex: collectBlock thenDo: doBlock [
	(items collectWithIndex: collectBlock)
		do: doBlock
]

{ #category : #iterating }
SpTreeBFSNode >> do: doBlock [
	items do: doBlock
]

{ #category : #searching }
SpTreeBFSNode >> indexOf: anItem [
	^ items indexOf: anItem
]

{ #category : #initialization }
SpTreeBFSNode >> initialize [ 
	parentPath := #()
]

{ #category : #accessing }
SpTreeBFSNode >> items: anItemList [
	items := anItemList
]

{ #category : #accessing }
SpTreeBFSNode >> parentPath [
	^ parentPath
]

{ #category : #accessing }
SpTreeBFSNode >> parentPath: aPath index: anIndex [
	"set the parent path with parent's parent path and parent's current index"
	parentPath := aPath copyWith: anIndex
]
