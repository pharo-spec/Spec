Class {
	#name : #SpMorphicTableLayout,
	#superclass : #TableLayout,
	#instVars : [
		'specLayout',
		'calculating'
	],
	#category : #'Spec2-Adapters-Morphic-Layout'
}

{ #category : #layout }
SpMorphicTableLayout >> applyHorizontalHomogeneousLayout: aMorph in: aRect [
	| allMorphs elementWidth |

	aMorph submorphs size = 2 ifFalse: [ 
		self error: 'It does not looks like a spec box panel' ].
	
	allMorphs := aMorph submorphs flatCollect: [ :each | each submorphs ].
	elementWidth := (aRect width - (self borderWidth * 2) - (self spacing * (allMorphs size - 1)) / (allMorphs size max: 1)) floor.

	allMorphs do: [ :each | 
		each minWidth: elementWidth ]
]

{ #category : #layout }
SpMorphicTableLayout >> applyVerticalHomogeneousLayout: aMorph in: aRect [
	| allMorphs elementHeight |

	aMorph submorphs size = 2 ifFalse: [ 
		self error: 'It does not looks like a spec box panel' ].
	
	allMorphs := aMorph submorphs flatCollect: [ :each | each submorphs ].
	elementHeight := (aRect height - (self borderWidth * 2) - (self spacing * (allMorphs size - 1)) / (allMorphs size max: 1)) floor.

	allMorphs do: [ :each | 
		each minHeight: elementHeight ]
]

{ #category : #accessing }
SpMorphicTableLayout >> borderWidth [

	^ specLayout borderWidth
]

{ #category : #accessing }
SpMorphicTableLayout >> direction [

	^ specLayout direction
]

{ #category : #initialization }
SpMorphicTableLayout >> initialize [

	super initialize.
	calculating := false
]

{ #category : #testing }
SpMorphicTableLayout >> isHomogeneous [

	^ specLayout isHomogeneous
]

{ #category : #layout }
SpMorphicTableLayout >> layout: aMorph in: aRect [

	calculating ifTrue: [ ^ self ].
	[
		calculating := true. 
		self isHomogeneous 
			ifTrue: [ self layoutHomogeneous: aMorph in: aRect ].
		super layout: aMorph in: aRect ]
	ensure: [
		calculating := false ]
]

{ #category : #layout }
SpMorphicTableLayout >> layoutHomogeneous: aMorph in: aRect [

	self direction 
		applyHomogeneousLayoutOn: self 
		to: aMorph 
		in: aRect
]

{ #category : #accessing }
SpMorphicTableLayout >> spacing [

	^ specLayout spacing
]

{ #category : #accessing }
SpMorphicTableLayout >> specLayout: aLayout [

	specLayout := aLayout
]
