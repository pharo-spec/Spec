Extension { #name : 'SpVerticalLayoutDirection' }

{ #category : '*Spec2-Adapters-Morphic' }
SpVerticalLayoutDirection >> addPadding: aNumber toMorph: aMorph into: anAdapter [

	^ anAdapter 
		addVerticalPadding: aNumber 
		toMorph: aMorph
]

{ #category : '*Spec2-Adapters-Morphic' }
SpVerticalLayoutDirection >> applyHomogeneousLayoutOn: aLayout to: aMorph in: aRect [

	aLayout applyVerticalHomogeneousLayout: aMorph in: aRect
]

{ #category : '*Spec2-Adapters-Morphic' }
SpVerticalLayoutDirection >> newSplitter [
	^ SpPanedResizerMorph newVertical
]

{ #category : '*Spec2-Adapters-Morphic' }
SpVerticalLayoutDirection >> recalculatePages: anAdaptor [

	^ anAdaptor recalculatePageHeights
]

{ #category : '*Spec2-Adapters-Morphic' }
SpVerticalLayoutDirection >> setResizingOfNonExpandedLayoutMorph: aMorph [
	"A nested layout takes the height of its content, which can change after it is built: a wrapping label gets its real width, and so its height, only when the window is laid out."

	aMorph
		hResizing: #spaceFill;
		vResizing: #shrinkWrap
]

{ #category : '*Spec2-Adapters-Morphic' }
SpVerticalLayoutDirection >> setRigidityOfNonExpandedMorph: aMorph [

	aMorph 
		hResizing: #spaceFill; 
		vResizing: #rigid
]
