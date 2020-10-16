Class {
	#name : #SpPaginatorPageMorph,
	#superclass : #Morph,
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

	self addMorphBack: (Morph new
		color: Color white;
		borderColor: Color darkGray;
		borderWidth: 1;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself)
]
