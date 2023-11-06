"
A base for the box layout to apply to inner widgets.
It uses one of the `SpMorphicBoxLayoutCalculator` to correctly distribute space, taking into account when space should be distributed homogeneously or not.

"
Class {
	#name : 'SpMorphicBaseBoxLayout',
	#superclass : 'TableLayout',
	#instVars : [
		'specLayout',
		'leftToRightCalculator',
		'topToBottomCalculator'
	],
	#category : 'Spec2-Adapters-Morphic-Layout',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Layout'
}

{ #category : 'layout' }
SpMorphicBaseBoxLayout >> applyHorizontalHomogeneousLayout: aMorph in: aRect [
	| allMorphs elementWidth |

	aMorph submorphs size = 2 ifFalse: [ 
		self error: 'It does not looks like a spec box panel' ].
	
	allMorphs := aMorph submorphs flatCollect: [ :each | each submorphs ].
	elementWidth := (aRect width - (self borderWidth * 2) - (self spacing * (allMorphs size - 1)) / (allMorphs size max: 1)) floor.

	allMorphs do: [ :each | 
		each setProperty: #homogeneousWidth toValue: elementWidth ]
]

{ #category : 'layout' }
SpMorphicBaseBoxLayout >> applyVerticalHomogeneousLayout: aMorph in: aRect [
	| allMorphs elementHeight |

	aMorph submorphs size = 2 ifFalse: [ 
		self error: 'It does not looks like a spec box panel' ].
	
	allMorphs := aMorph submorphs flatCollect: [ :each | each submorphs ].
	elementHeight := (aRect height - (self borderWidth * 2) - (self spacing * (allMorphs size - 1)) / (allMorphs size max: 1)) floor.

	allMorphs do: [ :each | 
		each minHeight: elementHeight ]
]

{ #category : 'accessing' }
SpMorphicBaseBoxLayout >> borderWidth [

	^ specLayout borderWidth
]

{ #category : 'accessing' }
SpMorphicBaseBoxLayout >> direction [

	^ specLayout direction
]

{ #category : 'testing' }
SpMorphicBaseBoxLayout >> isHomogeneous [

	^ specLayout isHomogeneous
]

{ #category : 'layout' }
SpMorphicBaseBoxLayout >> layoutHomogeneous: aMorph in: aRect [

	self direction 
		applyHomogeneousLayoutOn: self 
		to: aMorph 
		in: aRect
]

{ #category : 'private' }
SpMorphicBaseBoxLayout >> layoutLeftToRight: aMorph in: newBounds [

	self leftToRightCalculator
		calculateFor: aMorph
		in: newBounds
]

{ #category : 'private' }
SpMorphicBaseBoxLayout >> layoutTopToBottom: aMorph in: newBounds [

	self topToBottomCalculator
		calculateFor: aMorph 
		in: newBounds
]

{ #category : 'private' }
SpMorphicBaseBoxLayout >> leftToRightCalculator [

	^ leftToRightCalculator ifNil: [ leftToRightCalculator := self newLeftToRightCalculator ]
]

{ #category : 'private' }
SpMorphicBaseBoxLayout >> newLeftToRightCalculator [

	^ SpMorphicBoxLayoutCalculatorLeftToRight newProperties: properties
]

{ #category : 'private' }
SpMorphicBaseBoxLayout >> newTopToBottomCalculator [

	^ SpMorphicBoxLayoutCalculatorTopToBottom newProperties: properties
]

{ #category : 'accessing' }
SpMorphicBaseBoxLayout >> spacing [

	^ specLayout spacing
]

{ #category : 'accessing' }
SpMorphicBaseBoxLayout >> specLayout: aLayout [

	specLayout := aLayout
]

{ #category : 'private' }
SpMorphicBaseBoxLayout >> topToBottomCalculator [
	"there will be just one, we reuse the variable `calculator`"

	^ topToBottomCalculator ifNil: [ topToBottomCalculator := self newTopToBottomCalculator ]
]
