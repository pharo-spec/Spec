Extension { #name : #SpMockMenu }

{ #category : #'*Spec-MorphicBackendTests' }
SpMockMenu >> invokeModal [

	self shown: true
]

{ #category : #'*Spec-MorphicBackendTests' }
SpMockMenu >> isInWorld [
	
	^ false
]

{ #category : #'*Spec-MorphicBackendTests' }
SpMockMenu >> popUpEvent: evt in: aWorld [

	self shown: true
]

{ #category : #'*Spec-MorphicBackendTests' }
SpMockMenu >> popUpInWorld: aWorld [

	self shown: true
]

{ #category : #'*Spec-MorphicBackendTests' }
SpMockMenu >> setInvokingView: aRubTextEditor [
]
