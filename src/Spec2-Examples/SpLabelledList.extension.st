Extension { #name : #SpLabelledList }

{ #category : #'*Spec2-Examples' }
SpLabelledList classSide >> example [
	<sampleInstance>
	^ super example
]

{ #category : #'*Spec2-Examples' }
SpLabelledList classSide >> setUpExample: example [
	example items: {'item 1' . 'item 2'}
]
