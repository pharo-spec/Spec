Extension { #name : #SpApplication }

{ #category : #'*Spec2-Adapters-Morphic' }
SpApplication >> addStylesheet: aStylesheet [

	self ensureConfiguration.
	 self styleSheet: self styleSheet, aStylesheet
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpApplication >> addStylesheetFromString: aString [

	self addStylesheet: (SpStyleVariableSTONReader fromString: aString)
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpApplication >> defaultConfigurationForMorphic [

	^ SpMorphicConfiguration new
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpApplication >> styleSheet [
	"A stylesheet defines the application style. 
	 You can defins your own (but it don't, we will take the default)"

	^ self ensureConfiguration styleSheet
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpApplication >> styleSheet: aStyleSheet [

	^ self ensureConfiguration styleSheet: aStyleSheet
]
