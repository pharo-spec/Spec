"
A morph to grab borders of a `SpPaginatorSelectionMorph` and enlarge or contract its selection area.
Since it is designed to be contained in a specific morph (`SpPaginatorSelectionMorph`) and its morph it self is a part of a `SpPaginatorMorph`, it has some important assumptions: 

- the `SpPaginatorEdgeGripMorph>>#containerTarget` will be the owner of the target, and it limits  displacement of the selection morph.
- the target of the edge is the selection area always, and it can move (at least for the moment) just left or right.
"
Class {
	#name : #SpPaginatorEdgeGripMorph,
	#superclass : #EdgeGripMorph,
	#instVars : [
		'containerTarget'
	],
	#category : #'Spec2-Morphic-Paginator'
}

{ #category : #accessing }
SpPaginatorEdgeGripMorph >> adjustToFit: aNumber [

	(aNumber -> self left) crTrace.
	^ aNumber max: self left
]

{ #category : #accessing }
SpPaginatorEdgeGripMorph >> beLeft [

	self edgeName: #left
]

{ #category : #accessing }
SpPaginatorEdgeGripMorph >> beRight [

	self edgeName: #right
]

{ #category : #accessing }
SpPaginatorEdgeGripMorph >> containerTarget [

	^ containerTarget ifNil: [ self target owner ]
]

{ #category : #accessing }
SpPaginatorEdgeGripMorph >> containerTarget: anObject [
	containerTarget := anObject
]

{ #category : #initialization }
SpPaginatorEdgeGripMorph >> initialize [

	super initialize. 
	self
		hResizing: #rigid;
		vResizing: #spaceFill
]

{ #category : #'event handling' }
SpPaginatorEdgeGripMorph >> mouseMove: anEvent [

	self target ifNil: [ ^ self ].
	self containerTarget ifNotNil: [ 
		(anEvent cursorPoint x
			between: self containerTarget left 
			and: self containerTarget right)
			ifFalse: [ ^ self ] ].

	^ super mouseMove: anEvent

]

{ #category : #'event handling' }
SpPaginatorEdgeGripMorph >> mouseUp: anEvent [

	super mouseUp: anEvent.
	self owner mouseUp: anEvent
]

{ #category : #accessing }
SpPaginatorEdgeGripMorph >> positionPoint: aPoint [

	self position: (aPoint x) @ self top
]
