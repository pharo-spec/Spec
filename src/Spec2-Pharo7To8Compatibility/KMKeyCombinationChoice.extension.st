Extension { #name : #KMKeyCombinationChoice }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
KMKeyCombinationChoice >> platformCharacter [

	shortcuts do: [ :each | 
		each platformCharacter ifNotNil: [ :char | ^ char ] ].
	^ nil
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
KMKeyCombinationChoice >> platformModifier [

	shortcuts do: [ :each | 
		each platformModifier ifNotNil: [ :mod | ^ mod ] ].
	^ nil
]
