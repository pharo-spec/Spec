Extension { #name : #Morph }

{ #category : #'*Spec2-Adapters-Morphic' }
Morph >> asSpAdapter [

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
Morph >> treeRenderOn: aCanvas bounds: drawBounds color: drawColor font: aFont from: aMorph [

	self bounds: drawBounds.
	aMorph addMorphBack: self.
       
]

{ #category : #'*Spec2-Adapters-Morphic' }
Morph >> widthToDisplayInTree: aTree [

	^ self minExtent x
]
