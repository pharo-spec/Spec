Extension { #name : #SpApplication }

{ #category : #'*Spec2-Adapters-Morphic' }
SpApplication >> addStylesheet: aStylesheet [

	 self styleSheet: self styleSheet, aStylesheet
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpApplication >> addStylesheetFromString: aString [

	self addStylesheet: (SpStyleVariableSTONReader fromString: aString)
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpApplication >> styleSheet [
	"A stylesheet defines the application style. 
	 You can defins your own (but it don't, we will take the default)"

	^ self 
		propertyAt: #styleSheet 
		ifAbsent: [ SpStyle defaultStyleSheet ]
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpApplication >> styleSheet: aStyleClass [

	^ self 
		propertyAt: #styleSheet 
		put: aStyleClass
]
