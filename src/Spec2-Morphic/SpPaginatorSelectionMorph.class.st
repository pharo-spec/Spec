Class {
	#name : #SpPaginatorSelectionMorph,
	#superclass : #Morph,
	#instVars : [
		'lastMouseX',
		'lastX',
		'numberOfPagesShown',
		'onDragFinished',
		'onDragging'
	],
	#category : #'Spec2-Morphic-Paginator'
}

{ #category : #private }
SpPaginatorSelectionMorph >> announceDragFinished [

	onDragFinished ifNil: [ ^ self ].
	onDragFinished cull: self left
]

{ #category : #private }
SpPaginatorSelectionMorph >> baseWidth [

	^ SpPaginatorPageMorph baseWidth
]

{ #category : #initialization }
SpPaginatorSelectionMorph >> defaultColor [
	
	^ "self theme selectionColor"Color red alpha: 0.8
]

{ #category : #'event handling' }
SpPaginatorSelectionMorph >> handlesMouseDown: anEvent [

	^ true
]

{ #category : #'event handling' }
SpPaginatorSelectionMorph >> handlesMouseOver: anEvent [

	^ true
	
]

{ #category : #initialization }
SpPaginatorSelectionMorph >> initialize [

	super initialize.
	self 
		changeProportionalLayout;
		hResizing: #rigid;
		vResizing: #spaceFill.
	self numberOfPagesShown: 2
]

{ #category : #'event handling' }
SpPaginatorSelectionMorph >> mouseDown: anEvent [ 

	super mouseDown: anEvent.
	lastX := self left.
	lastMouseX := anEvent cursorPoint x
]

{ #category : #'event handling' }
SpPaginatorSelectionMorph >> mouseLeave: anEvent [

	super mouseLeave: anEvent.
	lastMouseX ifNil: [ ^ self ].
	lastMouseX := nil.
	self resetPosition
]

{ #category : #'event handling' }
SpPaginatorSelectionMorph >> mouseMove: anEvent [ 
	| x posX oldPosX |

	super mouseMove: anEvent.

	anEvent redButtonPressed ifFalse: [ ^ self ].
	lastMouseX ifNil: [ ^ self ].

	x := anEvent cursorPoint x.	
	posX := ((self left + (x - lastMouseX)) max: self owner left) min: (self owner right - self width).
	oldPosX := self left.
	self left: posX.
	lastMouseX := x.
	onDragging ifNotNil: [ 
		onDragging 
			cull: posX
			cull: oldPosX ]
]

{ #category : #'event handling' }
SpPaginatorSelectionMorph >> mouseUp: anEvent [ 

	super mouseMove: anEvent.
	lastMouseX := nil.
	self announceDragFinished
	
]

{ #category : #accessing }
SpPaginatorSelectionMorph >> numberOfPagesShown [

	^ numberOfPagesShown
]

{ #category : #accessing }
SpPaginatorSelectionMorph >> numberOfPagesShown: aNumber [

	numberOfPagesShown := aNumber.
	self width: self baseWidth * numberOfPagesShown
]

{ #category : #accessing }
SpPaginatorSelectionMorph >> onDragFinishedDo: aBlock [

	onDragFinished := aBlock
]

{ #category : #accessing }
SpPaginatorSelectionMorph >> onDraggingDo: aBlock [

	onDragging := aBlock
]

{ #category : #private }
SpPaginatorSelectionMorph >> resetPosition [

	lastX ifNil: [ ^ self ].
	self left: lastX.
	lastX := nil
]
