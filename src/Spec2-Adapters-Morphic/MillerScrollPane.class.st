"
A scroll pane to show a miller column list.
"
Class {
	#name : #MillerScrollPane,
	#superclass : #GeneralScrollPane,
	#instVars : [
		'layoutChangeAction',
		'updating',
		'firstShowingMorph'
	],
	#category : #'Spec2-Adapters-Morphic-Layout'
}

{ #category : #private }
MillerScrollPane >> basicShowMorph: aMorph [

	scroller offset: aMorph topLeft
]

{ #category : #initialization }
MillerScrollPane >> initialize [

	updating := false.
	super initialize
]

{ #category : #events }
MillerScrollPane >> layoutChanged [

	updating ifTrue: [ ^ self ].
	updating := true.
	[
		super layoutChanged.
		layoutChangeAction ifNotNil: [ layoutChangeAction value ] ]
	ensure: [ 
		updating := false ]
]

{ #category : #events }
MillerScrollPane >> onLayoutChange: aBlock [

	layoutChangeAction := aBlock
]

{ #category : #accessing }
MillerScrollPane >> showMorph: aMorph [

	firstShowingMorph := aMorph.
	self basicShowMorph: aMorph
]

{ #category : #geometry }
MillerScrollPane >> updateScrollbars [

	super updateScrollbars.
	firstShowingMorph ifNotNil: [ 
		scroller offset: firstShowingMorph topLeft ]
]
