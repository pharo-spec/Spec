"
I'm a paned vertical resizer.
I'm called ""vertical"" (even if my draw is horizontal) because I split vertically the panes between me.

self exampleVertical.
"
Class {
	#name : 'SpPanedResizerVerticalMorph',
	#superclass : 'SpPanedResizerMorph',
	#category : 'Spec2-Adapters-Morphic-Layout',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Layout'
}

{ #category : 'accessing' }
SpPanedResizerVerticalMorph >> edgeName [
	"Answer the value of edgeName"

	^ #bottom
]

{ #category : 'testing' }
SpPanedResizerVerticalMorph >> isHorizontal [
	"Answer true if the receiver has a horizontal layout."
	
	^ false
]

{ #category : 'accessing' }
SpPanedResizerVerticalMorph >> positionPoint: aPoint [
	"Reposition based on ptName."
	
	^ self position: self left @ aPoint y
]

{ #category : 'private' }
SpPanedResizerVerticalMorph >> setLayoutSizing [
	
	self 
		hResizing: #spaceFill; 
		vResizing: #rigid
]

{ #category : 'private' }
SpPanedResizerVerticalMorph >> setTargetBounds [
	self target ifNotNil: [ :t |
		t bounds: (t position corner: (t right @ self top)) ].
	self targetAfter ifNotNil: [ :ta |
		ta bounds: (ta left @ self bottom corner: ta bottomRight) ]
]

{ #category : 'private' }
SpPanedResizerVerticalMorph >> setTargetLayoutSizing [
	self isFromEnd
		ifTrue: [
			self targetAfter vResizing = #rigid ifTrue: [ ^ self ].
			self targetAfter vResizing: #rigid.
			self target vResizing: #spaceFill ]
		ifFalse: [
			self target vResizing = #rigid ifTrue: [ ^ self ].
			self target vResizing: #rigid.
			self targetAfter vResizing: #spaceFill ]
]
