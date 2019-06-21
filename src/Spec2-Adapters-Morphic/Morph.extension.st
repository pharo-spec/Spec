Extension { #name : #Morph }

{ #category : #'*Spec2-Adapters-Morphic' }
Morph >> asSpecAdapter [

	^ (SpBindings value 
		adapterClass: #GenericAdapter)
		morph: self
]

{ #category : #'*Spec2-Adapters-Morphic' }
Morph >> centerWidget: aWindow [

	aWindow
			fullBounds;
			center: self center
]

{ #category : #'*Spec2-Adapters-Morphic' }
Morph >> ensureLayoutAndAddMorph: aMorph [

	aMorph layoutFrame
		ifNil: [ aMorph layoutFrame: LayoutFrame identity].
	self addMorph: aMorph 
]

{ #category : #'*Spec2-Adapters-Morphic' }
Morph >> heightToDisplayInTree: aTree [

	^ self minExtent y
]

{ #category : #'*Spec2-Adapters-Morphic' }
Morph >> setModal: aSystemWindow [
	|area mySysWin keyboardFocus|

	keyboardFocus := self activeHand keyboardFocus.
	mySysWin := self isSystemWindow ifTrue: [self] ifFalse: [self ownerThatIsA: SystemWindow].
	mySysWin ifNil: [mySysWin := self].
	mySysWin modalLockTo: aSystemWindow.
	area := RealEstateAgent maximumUsableArea.
	aSystemWindow extent: aSystemWindow initialExtent.
	aSystemWindow position = (0@0)
		ifTrue: [aSystemWindow
				position: self activeHand position - (aSystemWindow extent // 2)].
	aSystemWindow
		bounds: (aSystemWindow bounds translatedToBeWithin: area).
	[ |aWidget | 
	aWidget := aSystemWindow.
	[aWidget world notNil] whileTrue: [
		aWidget outermostWorldMorph doOneCycle]]
		ensure: [mySysWin modalUnlockFrom: aSystemWindow.
				self activeHand newKeyboardFocus: keyboardFocus].
	^aSystemWindow
]

{ #category : #'*Spec2-Adapters-Morphic' }
Morph >> treeRenderOn: aCanvas bounds: drawBounds color: drawColor font: aFont from: aMorph [

	self bounds: drawBounds.
	aMorph addMorphBack: self.
       
]

{ #category : #'*Spec2-Adapters-Morphic' }
Morph >> widthToDisplayInTree: aTree [

	^ self minExtent x
]
