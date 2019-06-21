Extension { #name : #SpLabelledTextInput }

{ #category : #'*Spec-Examples' }
SpLabelledTextInput class >> example [
	<sampleInstance>
	^ super example
]

{ #category : #'*Spec-Examples' }
SpLabelledTextInput class >> setUpExample: example [
	example input placeholder: 'Tilt'.
	example extent: 400 @ 50
]
