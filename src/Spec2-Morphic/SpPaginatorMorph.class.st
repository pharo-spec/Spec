Class {
	#name : #SpPaginatorMorph,
	#superclass : #Morph,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#pagesMorph',
		'#selectionMorph',
		'#selectedPage => ObservableSlot'
	],
	#category : #'Spec2-Morphic-Paginator'
}

{ #category : #accessing }
SpPaginatorMorph class >> defaultHeight [

	^ 18
]

{ #category : #accessing }
SpPaginatorMorph >> addPage: anObject [

	pagesMorph addMorphBack: (SpPaginatorPageMorph new
		whenSelectedDo: [ :aMorph | self doSelectPageFromMorph: aMorph ];
		yourself).
	self width: pagesMorph submorphs size * self baseWidth
]

{ #category : #accessing }
SpPaginatorMorph >> addPages: aCollection [

	aCollection do: [ :each | self addPage: each ]
]

{ #category : #private }
SpPaginatorMorph >> adjustSelectionToClosestPage [
	| closestPage |

	closestPage := ((selectionMorph left - self left) / self baseWidth) rounded + 1.	
	selectionMorph left: self left + ((closestPage - 1) * self baseWidth).
	
	closestPage = self selectedPage ifFalse: [ 
		self basicSelectPage: closestPage ]

]

{ #category : #private }
SpPaginatorMorph >> baseWidth [

	^ SpPaginatorPageMorph baseWidth
]

{ #category : #private }
SpPaginatorMorph >> basicSelectPage: aNumber [
	
	selectedPage := aNumber
]

{ #category : #geometry }
SpPaginatorMorph >> bounds: aRectangle [

	super bounds: aRectangle.
	selectionMorph height: aRectangle height
]

{ #category : #initialization }
SpPaginatorMorph >> defaultColor [

	^ Color transparent
]

{ #category : #private }
SpPaginatorMorph >> doSelectPageFromMorph: aMorph [

	self selectPage: (pagesMorph submorphs indexOf: aMorph)
]

{ #category : #initialization }
SpPaginatorMorph >> initialize [

	self class initializeSlots: self.
	super initialize.
	self 
		vResizing: #rigid;
		hResizing: #shrinkWrap;
		height: self class defaultHeight.

	self addMorphBack: (selectionMorph := self newSelectionMorph).
	self addMorphBack: (pagesMorph := self newPagesMorph).
	
	self basicSelectPage: 1. "We select the first page first"
]

{ #category : #private }
SpPaginatorMorph >> moveNext [
	self flag: #REMOVE. 
	selectionMorph left: (((selectionMorph left + selectionMorph width) + self baseWidth) > self right 
		ifTrue: [ 0 ]
		ifFalse: [ selectionMorph left + self baseWidth ])
]

{ #category : #private }
SpPaginatorMorph >> moveSelectionToPage: aNumber [

	selectionMorph left: self left + ((aNumber - 1) * self baseWidth)
]

{ #category : #initialization }
SpPaginatorMorph >> newPagesMorph [

	^ Morph new 
		color: Color transparent;
		changeTableLayout; 
		listDirection: #leftToRight; 
		hResizing: #shrinkWrap;
		vResizing: #rigid;
		height: self class defaultHeight;
		yourself
]

{ #category : #initialization }
SpPaginatorMorph >> newSelectionMorph [
	
	^ SpPaginatorSelectionMorph new
		vResizing: #rigid;
		height: self height;
		onDragFinishedDo: [ self adjustSelectionToClosestPage ];
		yourself
]

{ #category : #accessing }
SpPaginatorMorph >> numberOfPagesShown [

	^ selectionMorph numberOfPagesShown
]

{ #category : #accessing }
SpPaginatorMorph >> numberOfPagesShown: aNumber [

	selectionMorph numberOfPagesShown: aNumber
]

{ #category : #accessing }
SpPaginatorMorph >> selectLastPage [

	self selectPage: (pagesMorph submorphs size)
]

{ #category : #accessing }
SpPaginatorMorph >> selectPage: aNumber [

	selectedPage = aNumber ifTrue: [ ^ self ].
	(aNumber + self numberOfPagesShown - 1 > pagesMorph submorphs size) 
		ifTrue: [ ^ self selectPage: aNumber - 1 ].

	self moveSelectionToPage: aNumber.
	self basicSelectPage: aNumber
]

{ #category : #accessing }
SpPaginatorMorph >> selectedPage [

	^ selectedPage
]

{ #category : #accessing }
SpPaginatorMorph >> selectedPages [
	
	^ (self selectedPage to: self selectedPage + self numberOfPagesShown - 1) asArray
]

{ #category : #events }
SpPaginatorMorph >> whenSelectedPageChangedDo: aBlock [ 

	self property: #selectedPage whenChangedDo: aBlock
]
