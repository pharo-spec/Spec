"
I implement the Breadth First Search algorithm for a SpTreePresenter.
I use SpTreeBFSNode to remember the path.

To use me, set the SpTreePresenter with #tree: and then search an element in the tree.
Search will return the path to the item if found or signal NotFound if the item cannot be found in the tree.
"
Class {
	#name : #SpTreeBreadthFirstSearch,
	#superclass : #Object,
	#instVars : [
		'queue',
		'tree',
		'visited',
		'itemToSearch',
		'path'
	],
	#category : #'Spec2-Core-Widgets-Tree'
}

{ #category : #initialization }
SpTreeBreadthFirstSearch >> initialize [ 
	queue := WaitfreeQueue new.
	visited := Set new.
	path := OrderedCollection new.
	
]

{ #category : #searching }
SpTreeBreadthFirstSearch >> search: anItem [
	| items index |
	itemToSearch := anItem.
	
	[ queue isEmpty ] whileFalse: [ 
		items := queue nextIfNone: [ NotFound signalFor: anItem in: tree ].
	
		index := items indexOf: itemToSearch.
		index = 0 ifFalse: [ ^ items parentPath copyWith: index "stop the algo" ].
	
		visited addAll: items.
		items 
			collectWithIndex: [ :item :itemIndex | 
				SpTreeBFSNode new
					items: (tree childrenFor: item);
					parentPath: items parentPath index: itemIndex ]
		 	thenDo: [ :children | 
				(visited includesAll: children)
					ifFalse: [ queue nextPut: children ] ]
	].
	NotFound signalFor: anItem in: tree.
]

{ #category : #initialization }
SpTreeBreadthFirstSearch >> tree: aSpTreePresenter [
	tree := aSpTreePresenter.
	queue nextPut: (SpTreeBFSNode items: tree roots).
]
