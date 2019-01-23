"
I'm a paned horizontal resizer.
I'm called ""horizonal"" (even if my draw is vertical) because I split horizontally the panes between me.

self exampleHorizontal.
"
Class {
	#name : #PanedResizerHorizontalMorph,
	#superclass : #PanedResizerMorph,
	#category : #'Spec-MorphicAdapters-Layout'
}

{ #category : #accessing }
PanedResizerHorizontalMorph >> edgeName [
	"Answer the value of edgeName"

	^ #right
]

{ #category : #accessing }
PanedResizerHorizontalMorph >> gripLayoutFrame [
	"Answer the layout frame dependinbg on our edge."
	
	^ (0 @ 0 corner: 1 @ 0) asLayoutFrame 
		topLeftOffset: 22 @ -29 ;
		bottomRightOffset:  -22 @ (SystemWindow borderWidth - 29)
]

{ #category : #testing }
PanedResizerHorizontalMorph >> isHorizontal [
	"Answer true if the receiver has a horizontal layout."
	
	^ true
]

{ #category : #accessing }
PanedResizerHorizontalMorph >> positionPoint: aPoint [
	"Reposition based on ptName."
	
	^ self position: self left @ aPoint y
]

{ #category : #private }
PanedResizerHorizontalMorph >> setLayoutSizing [
	"Adjust the sizing for use within table layouts."

	self 
		hResizing: #rigid; 
		vResizing: #spaceFill
]

{ #category : #private }
PanedResizerHorizontalMorph >> setTargetLayoutSizing [

	(self target hResizing = #rigid) ifTrue: [ ^ self ].
	self target hResizing: #rigid
]
