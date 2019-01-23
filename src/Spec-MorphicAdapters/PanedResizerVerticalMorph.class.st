"
I'm a paned vertical resizer.
I'm called ""vertical"" (even if my draw is horizontal) because I split vertically the panes between me.

self exampleVertical.
"
Class {
	#name : #PanedResizerVerticalMorph,
	#superclass : #PanedResizerMorph,
	#category : #'Spec-MorphicAdapters-Layout'
}

{ #category : #accessing }
PanedResizerVerticalMorph >> edgeName [
	"Answer the value of edgeName"

	^ #bottom
]

{ #category : #accessing }
PanedResizerVerticalMorph >> gripLayoutFrame [
	"Answer the layout frame dependinbg on our edge."
	
	^ (0 @ 1 corner: 1 @ 1) asLayoutFrame 
		topLeftOffset: 22 @ SystemWindow borderWidth negated ;
		rightOffset: -22
]

{ #category : #testing }
PanedResizerVerticalMorph >> isHorizontal [
	"Answer true if the receiver has a horizontal layout."
	
	^ false
]

{ #category : #accessing }
PanedResizerVerticalMorph >> positionPoint: aPoint [
	"Reposition based on ptName."
	
	^ self position: aPoint x @ self top
]

{ #category : #private }
PanedResizerVerticalMorph >> setLayoutSizing [
	
	self 
		hResizing: #spaceFill; 
		vResizing: #rigid
]

{ #category : #private }
PanedResizerVerticalMorph >> setTargetLayoutSizing [

	(self target vResizing = #rigid) ifTrue: [ ^ self ].
	self target vResizing: #rigid
]
