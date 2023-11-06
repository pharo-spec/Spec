"
A scroll pane to show a miller column list.
"
Class {
	#name : 'MillerScrollPaneMorph',
	#superclass : 'GeneralScrollPaneMorph',
	#instVars : [
		'layoutChangeAction',
		'updating',
		'firstShowingMorph',
		'keepShowingPage'
	],
	#category : 'Spec2-Adapters-Morphic-Layout',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Layout'
}

{ #category : 'private' }
MillerScrollPaneMorph >> basicShowMorph: aMorph [

	scroller offset: aMorph topLeft
]

{ #category : 'scrollbars' }
MillerScrollPaneMorph >> hScrollbarShowNever [

	super hScrollbarShowNever.
	"Since I am showing a scroll bar, I do not need to keep the page."
	self keepShowingPage: true
]

{ #category : 'scrollbars' }
MillerScrollPaneMorph >> hScrollbarShowWhenNeeded [

	super hScrollbarShowWhenNeeded.
	"Since I am showing a scroll bar, I do not need to keep the page."
	self keepShowingPage: false
]

{ #category : 'initialization' }
MillerScrollPaneMorph >> initialize [

	super initialize.
	updating := false.
	keepShowingPage := false
]

{ #category : 'testing' }
MillerScrollPaneMorph >> isUpdating [

	^ updating ifNil: [ updating := false ]
]

{ #category : 'private' }
MillerScrollPaneMorph >> keepShowingPage: aBoolean [

	keepShowingPage := aBoolean.
	keepShowingPage ifFalse: [ 
		firstShowingMorph := nil ]
]

{ #category : 'events' }
MillerScrollPaneMorph >> layoutChanged [

	self isUpdating ifTrue: [ ^ self ].
	updating := true.
	[ 
	super layoutChanged.
	layoutChangeAction ifNotNil: [ layoutChangeAction value ] ] ensure: [ 
		updating := false ]
]

{ #category : 'events' }
MillerScrollPaneMorph >> onLayoutChange: aBlock [

	layoutChangeAction := aBlock
]

{ #category : 'accessing' }
MillerScrollPaneMorph >> showMorph: aMorph [
	
	keepShowingPage 
		ifTrue: [ firstShowingMorph := aMorph ].
	self basicShowMorph: aMorph
]

{ #category : 'updating' }
MillerScrollPaneMorph >> updateScrollbars [

	super updateScrollbars.
	firstShowingMorph ifNotNil: [ 
		scroller offset: firstShowingMorph topLeft ]
]

{ #category : 'scrollbars' }
MillerScrollPaneMorph >> vScrollbarNeeded [
	"Return whether the vertical scrollbar is needed."

	self vScrollbar showsAlways ifTrue: [ ^ true ].
	self vScrollbar showsNever ifTrue: [ ^ false ].	
 	keepShowingPage ifNil: [ ^ super vScrollbarNeeded ].
	
	^ self scrollTarget height > self innerBounds height
]
