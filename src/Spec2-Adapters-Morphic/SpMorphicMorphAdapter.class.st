Class {
	#name : #SpMorphicMorphAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #factory }
SpMorphicMorphAdapter >> buildWidget [
	| panel |

	panel := PanelMorph new 
		changeTableLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		color: Color transparent;
		borderColor: Color transparent;
		yourself.
		
	self presenter morph 
		ifNotNil: [ :morph | panel addMorphBack: morph ].
	self presenter 
		whenMorphChangedDo: [ :morph | 
			panel 
				removeAllMorphs;
				addMorphBack: morph ].
	
	^ panel
]
