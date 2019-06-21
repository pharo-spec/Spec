Extension { #name : #SpLabelledList }

{ #category : #'*Spec-Examples' }
SpLabelledList class >> example [
	<sampleInstance>
	^ super example
]

{ #category : #'*Spec-Examples' }
SpLabelledList class >> setUpExample: example [
	example items: {'item 1' . 'item 2'}
]
