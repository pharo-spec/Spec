Class {
	#name : #SpTreeBreadthFirstSearchTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #running }
SpTreeBreadthFirstSearchTest >> setUp [
	presenter := SpTreeTablePresenter new
		addColumn: (SpStringTableColumn title: 'Value' evaluated: #printString);
		beMultipleSelection;
		roots: #(1 2 3);
		children: [ :aNumber | 
			aNumber < 100
				ifTrue: [ { aNumber * 2. aNumber * 3. aNumber * 10 } ]
				ifFalse: [ #() ] ];
		yourself.
]

{ #category : #tests }
SpTreeBreadthFirstSearchTest >> testCanGetItemInChildren [
	| result |
	result := SpTreeBreadthFirstSearch new 
		tree: presenter;
		search: 20.
	
	self assert: result equals: #(2 3).
]

{ #category : #tests }
SpTreeBreadthFirstSearchTest >> testCanGetItemInRoots [
	| result |
	result := SpTreeBreadthFirstSearch new 
		tree: presenter;
		search: 2.
	
	self assert: result equals: #(2).
]

{ #category : #tests }
SpTreeBreadthFirstSearchTest >> testDoesNotVisitAlreadyVisitedItems [
	| treeBFS |
	presenter
		children: [ :aNumber | { ((aNumber + 1) % 10) . ((aNumber + 2) % 10) . ((aNumber + 3) % 10) }].
	
	treeBFS := SpTreeBreadthFirstSearch new 
		tree: presenter;
		yourself.
	
	self should: [ treeBFS search: 20 ] raise: NotFound
]

{ #category : #tests }
SpTreeBreadthFirstSearchTest >> testRaiseNotFoundWhenSearchingItemInEmptyTree [ 
	| treeBFS |
	presenter roots: #().
	treeBFS := SpTreeBreadthFirstSearch new 
		tree: presenter.
	
	self should: [ treeBFS search: 0 ] raise: NotFound
]

{ #category : #tests }
SpTreeBreadthFirstSearchTest >> testRaiseNotFoundWhenSearchingItemNotInTree [
	| treeBFS |
	treeBFS := SpTreeBreadthFirstSearch new 
		tree: presenter.
	
	self should: [ treeBFS search: 0 ] raise: NotFound
]
