Class {
	#name : #SpPaginatorPageMorph,
	#superclass : #Morph,
	#instVars : [
		'selectedBlock'
	],
	#category : #'Spec2-Morphic-Paginator'
}

{ #category : #accessing }
SpPaginatorPageMorph class >> baseWidth [

	^ 12
]

{ #category : #accessing }
SpPaginatorPageMorph class >> defaultInset [

	^ 2
]

{ #category : #'event handling' }
SpPaginatorPageMorph >> handlesMouseDown: event [

	^ true
]

{ #category : #initialization }
SpPaginatorPageMorph >> initialize [

	super initialize.
	self 
		color: Color transparent;
		changeTableLayout;
		listDirection: #leftToRight;
		cellInset: self class defaultInset;
		cellSpacing: self class defaultInset;
		hResizing: #rigid;
		vResizing: #spaceFill;
		width: self class baseWidth.

	self addMorphBack: self newContentMorph.
]

{ #category : #'event handling' }
SpPaginatorPageMorph >> mouseDown: event [

	super mouseDown: event.
	selectedBlock ifNotNil: [ 
		selectedBlock value: self ]
]

{ #category : #initialization }
SpPaginatorPageMorph >> newContentMorph [

	^ Morph new
		color: Color white;
		borderColor: Color darkGray;
		borderWidth: 1;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself
]

{ #category : #events }
SpPaginatorPageMorph >> whenSelectedDo: aBlock [

	selectedBlock := aBlock
]
