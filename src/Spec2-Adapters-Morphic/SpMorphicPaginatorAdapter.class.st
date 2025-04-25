Class {
	#name : 'SpMorphicPaginatorAdapter',
	#superclass : 'SpAbstractMorphicAdapter',
	#traits : 'SpTBackendUpdating',
	#classTraits : 'SpTBackendUpdating classTrait',
	#category : 'Spec2-Adapters-Morphic-Paginator',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Paginator'
}

{ #category : 'factory' }
SpMorphicPaginatorAdapter >> buildWidget [
	| morph page |
	
	morph := SpPaginatorMorph new
		addPages: self presenter pages;
		yourself.

	self presenter whenSelectedPageChangedDo: [ :aNumber |
		self withCycleDetectionOnBackendDo: [ 
			morph selectPage: aNumber ] ].
	morph whenSelectedPageChangedDo: [ :aNumber |
		self backendUpdatingDo: [ 
			self presenter selectPage: aNumber ] ].

	morph numberOfPagesShown: self presenter visiblePages.
	self presenter whenVisiblePagesChangedDo: [ :aNumber |
		self withCycleDetectionOnBackendDo: [ 
			morph numberOfPagesShown: aNumber ] ].
	morph whenNumberOfPagesShownChangedDo: [ :aNumber |
		self backendUpdatingDo: [
			self presenter visiblePages: aNumber ] ].

	self presenter whenPageAddedDo: [ :anObject | 
		morph 
			addPage: anObject; 
			selectLastPage ].
	self presenter whenPageRemovedDo: [ :anObject |
		anObject 
			ifNotNil: [ morph removePage: anObject ]
			ifNil: [ morph removeAllPages ] ].
		
	morph selectionMorph whenDraggingDo: [ :delta | 
		self presenter dragging: (delta * 100 / widget width) ].

	"select last because the real selection may change with the visible pages"
	page := (self presenter selectedPage
		ifNil: [ self presenter pages size ]).
	morph 	selectPage: page.	
	self backendUpdatingDo: [ 
		self presenter selectPage: page ]. 

	^ morph
]

{ #category : 'initialization' }
SpMorphicPaginatorAdapter >> initialize [

	super initialize.
	self initializeTBackendUpdating
]

{ #category : 'paginator' }
SpMorphicPaginatorAdapter >> scrollByDeltaPercent: percent [
	| millerWidth millerDelta |
	
	millerWidth := self widget scroller localSubmorphBounds width.
	millerDelta := millerWidth * (percent / 100).
	self widget scroller offset: (self widget scroller offset x + millerDelta)@0
]

{ #category : 'paginator' }
SpMorphicPaginatorAdapter >> withoutResizingEdges [

	self widgetDo: [ :w | w removeResizingEdges ]
]
