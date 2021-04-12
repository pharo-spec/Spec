Extension { #name : #SpLabelledTextInput }

{ #category : #'*Spec2-Examples' }
SpLabelledTextInput classSide >> example [
	<sampleInstance>
	^ super example
]

{ #category : #'*Spec2-Examples' }
SpLabelledTextInput classSide >> setUpExample: example [
	example input placeholder: 'Tilt'.
	example extent: 400 @ 50
]
