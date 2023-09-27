Extension { #name : 'SpHorizontalLayoutDirection' }

{ #category : '*Spec2-Adapters-Morphic' }
SpHorizontalLayoutDirection >> addPadding: aNumber toMorph: aMorph into: anAdapter [

	^ anAdapter 
		addHorizontalPadding: aNumber 
		toMorph: aMorph
]

{ #category : '*Spec2-Adapters-Morphic' }
SpHorizontalLayoutDirection >> applyHomogeneousLayoutOn: aLayout to: aMorph in: aRect [

	aLayout applyHorizontalHomogeneousLayout: aMorph in: aRect
]

{ #category : '*Spec2-Adapters-Morphic' }
SpHorizontalLayoutDirection >> newSplitter [

	^ SpPanedResizerMorph newHorizontal
]

{ #category : '*Spec2-Adapters-Morphic' }
SpHorizontalLayoutDirection >> recalculatePages: anAdaptor [

	^ anAdaptor recalculatePageWidths
]

{ #category : '*Spec2-Adapters-Morphic' }
SpHorizontalLayoutDirection >> setRigidityOfNonExpandedMorph: aMorph [

	aMorph 
		vResizing: #spaceFill; 
		hResizing: #rigid
]
