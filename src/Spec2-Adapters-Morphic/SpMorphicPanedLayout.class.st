"
I am a specialized TableLayout for PanedLayouts in the Morphic adapter.

I manage rigid and spaceFill resizing constraints for the first and second child submorphs based on `#position`:
- Fixed values (|position| >= 1):
    Positive (e.g. 200): First submorph is rigid with specified width/height; last submorph is spaceFill.
    Negative (e.g. -200): Last submorph is rigid with absolute width/height; first submorph is spaceFill.
- Proportional values (|position| < 1):
    Submorph sizes are updated proportionally on layout passes.
- Splitter interaction:
    When the splitter is dragged, the sizing mode (fixed vs proportional, start vs end) is preserved rather than being forcibly coerced into a percentage.
"
Class {
	#name : 'SpMorphicPanedLayout',
	#superclass : 'TableLayout',
	#instVars : [
		'position',
		'isResizing'
	],
	#category : 'Spec2-Adapters-Morphic-Layout',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Layout'
}

{ #category : 'private' }
SpMorphicPanedLayout >> computePreservedPositionOn: layoutedMorph [
	| targetMorph newDimension delta |
	targetMorph := self isFromEnd
		ifTrue: [ layoutedMorph submorphs last ]
		ifFalse: [ layoutedMorph submorphs first ].

	newDimension := self isHorizontal
		ifTrue: [ targetMorph width ]
		ifFalse: [ targetMorph height ].

	self isFixed ifTrue: [
		^ self isFromEnd
			ifTrue: [ newDimension asInteger negated ]
			ifFalse: [ newDimension asInteger ] ].

	delta := self isHorizontal
		ifTrue: [ (newDimension * 100 / layoutedMorph width) asInteger percent ]
		ifFalse: [ (newDimension * 100 / layoutedMorph height) asInteger percent ].

	^ self isFromEnd
		ifTrue: [ delta negated ]
		ifFalse: [ delta ]
]

{ #category : 'private' }
SpMorphicPanedLayout >> ensureHeightPosition: aMorph in: aRect [
	| targetMorph otherMorph height |
	self position ifNil: [ ^ self ].
	self isResizing ifTrue: [ ^ self ].
	aMorph submorphs size < 3 ifTrue: [ ^ self ].

	targetMorph := self isFromEnd
		ifTrue: [ aMorph submorphs last ]
		ifFalse: [ aMorph submorphs first ].
	otherMorph := self isFromEnd
		ifTrue: [ aMorph submorphs first ]
		ifFalse: [ aMorph submorphs last ].

	targetMorph vResizing = #rigid ifFalse: [ targetMorph vResizing: #rigid ].
	otherMorph vResizing = #spaceFill ifFalse: [ otherMorph vResizing: #spaceFill ].

	height := self heightPositionIn: aRect extent.
	targetMorph height = height ifFalse: [ targetMorph height: height ]
]

{ #category : 'private' }
SpMorphicPanedLayout >> ensureWidthPosition: aMorph in: aRect [
	| targetMorph otherMorph width |
	self position ifNil: [ ^ self ].
	self isResizing ifTrue: [ ^ self ].
	aMorph submorphs size < 3 ifTrue: [ ^ self ].

	targetMorph := self isFromEnd
		ifTrue: [ aMorph submorphs last ]
		ifFalse: [ aMorph submorphs first ].
	otherMorph := self isFromEnd
		ifTrue: [ aMorph submorphs first ]
		ifFalse: [ aMorph submorphs last ].

	targetMorph hResizing = #rigid ifFalse: [ targetMorph hResizing: #rigid ].
	otherMorph hResizing = #spaceFill ifFalse: [ otherMorph hResizing: #spaceFill ].

	width := self widthPositionIn: aRect extent.
	targetMorph width = width ifFalse: [ targetMorph width: width ]
]

{ #category : 'private' }
SpMorphicPanedLayout >> heightPositionIn: aPoint [
	self position ifNil: [ ^ (aPoint y * 0.5) asInteger ].
	self isFixed ifTrue: [ ^ self position abs asInteger ].
	^ (aPoint y * self position abs) asInteger
]

{ #category : 'testing' }
SpMorphicPanedLayout >> isFixed [
	^ self position isNotNil and: [ self position abs >= 1 ]
]

{ #category : 'testing' }
SpMorphicPanedLayout >> isFromEnd [
	^ self position isNotNil and: [ self position < 0 ]
]

{ #category : 'testing' }
SpMorphicPanedLayout >> isHorizontal [

	^ (properties listDirection == #topToBottom 
		or: [ properties listDirection == #bottomToTop ]) not
]

{ #category : 'testing' }
SpMorphicPanedLayout >> isResizing [
	^ isResizing ifNil: [ false ]
]

{ #category : 'layout' }
SpMorphicPanedLayout >> layoutLeftToRight: aMorph in: newBounds [

	self ensureWidthPosition: aMorph in: newBounds.
	super layoutLeftToRight: aMorph in: newBounds
]

{ #category : 'layout' }
SpMorphicPanedLayout >> layoutTopToBottom: aMorph in: newBounds [

	self ensureHeightPosition: aMorph in: newBounds.
	super layoutTopToBottom: aMorph in: newBounds
]

{ #category : 'accessing' }
SpMorphicPanedLayout >> position [
	^ position
]

{ #category : 'accessing' }
SpMorphicPanedLayout >> position: anObject [
	position := anObject.
	isResizing := false
]

{ #category : 'actions' }
SpMorphicPanedLayout >> preservePositionProportionOn: layoutedMorph [
	isResizing := false.
	layoutedMorph submorphs size < 3 ifTrue: [ ^ self ].

	position := self computePreservedPositionOn: layoutedMorph.
	layoutedMorph layoutChanged
]

{ #category : 'actions' }
SpMorphicPanedLayout >> resetPosition [
	"Flag that splitter dragging is active so intermediate relayout passes do not override manual adjustment."
	isResizing := true
]

{ #category : 'private' }
SpMorphicPanedLayout >> widthPositionIn: aPoint [
	self position ifNil: [ ^ (aPoint x * 0.5) asInteger ].
	self isFixed ifTrue: [ ^ self position abs asInteger ].
	^ (aPoint x * self position abs) asInteger
]
