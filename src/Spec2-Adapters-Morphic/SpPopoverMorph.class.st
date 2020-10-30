"
I am a popover morph, which is a morph who will pop in relation to another morph (or/and in a relative position). 
It has a position: top, left, bottom and right (default is right).
It will be dismissed if click outside or keyboard focus translate to another place other than its children.
"
Class {
	#name : #SpPopoverMorph,
	#superclass : #PanelMorph,
	#instVars : [
		'position',
		'relativeTo'
	],
	#category : #'Spec2-Adapters-Morphic-Support'
}

{ #category : #accessing }
SpPopoverMorph >> bePositionBottom [

	position := #bottom
]

{ #category : #accessing }
SpPopoverMorph >> bePositionLeft [

	position := #left
]

{ #category : #accessing }
SpPopoverMorph >> bePositionRight [

	position := #right
]

{ #category : #accessing }
SpPopoverMorph >> bePositionTop [

	position := #top
]

{ #category : #accessing }
SpPopoverMorph >> beRelativeTo: aMorph [

	relativeTo := aMorph
]

{ #category : #private }
SpPopoverMorph >> calculatePositionBottomFrom: aRect [
	| x y |
	
	y := aRect corner y + self separatatedBy.
	x := aRect corner x - ((aRect width + self width) // 2).

	^ x @ y
	
]

{ #category : #private }
SpPopoverMorph >> calculatePositionFrom: aRect [

	position = #top ifTrue: [ ^ self calculatePositionTopFrom: aRect ].
	position = #left ifTrue: [ ^ self calculatePositionLeftFrom: aRect ].
	position = #bottom ifTrue: [ ^ self calculatePositionBottomFrom: aRect ].
	position = #right ifTrue: [ ^ self calculatePositionRightFrom: aRect ].
	
	self error: 'Should not arrive here'


	
]

{ #category : #private }
SpPopoverMorph >> calculatePositionLeftFrom: aRect [
	| x y |
	
	x := aRect origin x - self separatatedBy - self width.
	y := aRect origin y.

	^ x @ y	
]

{ #category : #private }
SpPopoverMorph >> calculatePositionRightFrom: aRect [
	| x y |
	
	x := aRect corner x + self separatatedBy.
	y := aRect origin y.

	^ x @ y
]

{ #category : #private }
SpPopoverMorph >> calculatePositionTopFrom: aRect [
	| x y |
	
	y := aRect origin y - self separatatedBy - self height.
	x := aRect corner x - ((aRect width + self width) // 2).

	^ x @ y	
]

{ #category : #accessing }
SpPopoverMorph >> contentMorph: aMorph [ 

	self removeAllMorphs.
	self extent: aMorph extent 
		+ (self borderWidth * 2) 
		+ (aMorph borderWidth * 2) 
		+ (self cellInset * 2).
	self addMorphBack: aMorph.
	 "I need this to calculate properly the size (otherwise I cannot position 
	  the popover correctly"
	self computeFullBounds
]

{ #category : #accessing }
SpPopoverMorph >> defaultColor [

	^ self theme lightBaseColor
]

{ #category : #'submorphs-add/remove' }
SpPopoverMorph >> delete [

	self activeHand ifNotNil: [ :hand | hand removeMouseListener: self ].
	super delete 
]

{ #category : #'event handling' }
SpPopoverMorph >> handlesMouseDown: evt [
	
	^ true
]

{ #category : #initialization }
SpPopoverMorph >> initialize [

	super initialize.
	self 
		changeTableLayout;
		listDirection: #leftToRight;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap;
		"onAnnouncement: MorphLostFocus do: [ :ann | ann morph popdown ];"
		"cellInset: 5;"
		beSticky.
	self bePositionBottom
]

{ #category : #'event handling' }
SpPopoverMorph >> justDroppedInto: aMorph event: evt [
	
	super justDroppedInto: aMorph event: evt.
	self takeMouseFocus
]

{ #category : #'event handling' }
SpPopoverMorph >> mouseDown: evt [
	"Handle a mouse down event."
	"Overridden to not grab on mouse down"
	
	(self fullContainsPoint: evt position) 
		ifFalse:[ ^ self delete ]. "click outside"
	self comeToFront.
	self takeMouseFocus
]

{ #category : #'event handling' }
SpPopoverMorph >> mouseUp: evt [
	"Handle a mouse up event.
	Note: This might be sent from a modal shell."
	(self fullContainsPoint: evt position) ifFalse: [
		"Mouse up outside. Release eventual focus and delete if pop up."
		evt hand releaseMouseFocus: self.
		^ self delete ]
]

{ #category : #api }
SpPopoverMorph >> popdown [
	
	self delete
]

{ #category : #api }
SpPopoverMorph >> popup [

	self popupPointingTo: self relativeTo boundsInWorld
]

{ #category : #api }
SpPopoverMorph >> popupPointingTo: aRectangle [

	self setPositionFrom: aRectangle.
	self openInWorld.
	self takeKeyboardFocus.
	self takeMouseFocus.
	self activeHand addMouseListener: self
]

{ #category : #accessing }
SpPopoverMorph >> relativeTo [ 

	^ relativeTo
]

{ #category : #private }
SpPopoverMorph >> separatatedBy [

	^ 5
]

{ #category : #private }
SpPopoverMorph >> setPositionFrom: aRect [

	self position: (self calculatePositionFrom: aRect)

	
]

{ #category : #'event handling' }
SpPopoverMorph >> takeMouseFocus [
	
	self activeHand newMouseFocus: self
]

{ #category : #'event handling' }
SpPopoverMorph >> takesKeyboardFocus [

	^ true
]
