Extension { #name : #SpLabelledDropList }

{ #category : #'*Spec2-Examples' }
SpLabelledDropList classSide >> example [
	<sampleInstance>
	^ super example
]

{ #category : #'*Spec2-Examples' }
SpLabelledDropList classSide >> setUpExample: example [
	example
		items: {'item 1' . 'item 2'};
		display: [ :item | item asString ];
		extent: 400 @ 50
]
