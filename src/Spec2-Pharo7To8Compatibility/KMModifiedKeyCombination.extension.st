Extension { #name : #KMModifiedKeyCombination }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
KMModifiedKeyCombination >> platformCharacter [
	
	^ self character key
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
KMModifiedKeyCombination >> platformModifier [
	
	^ self modifier
]
