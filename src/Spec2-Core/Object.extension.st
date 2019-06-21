Extension { #name : #Object }

{ #category : #'*Spec2-Core' }
Object >> asWidget [

	^ self
]

{ #category : #'*Spec2-Core' }
Object >> isAnnouncingObject [

	^ false
]

{ #category : #'*Spec2-Core' }
Object >> isSpecContainer [
	^ false
]

{ #category : #'*Spec2-Core' }
Object >> isSpecLayout [

	^ false
]

{ #category : #'*Spec2-Core' }
Object >> wrappedInValueHolderIfNeeded [

	^ self asValueHolder
]
