Extension { #name : #SpImagePresenter }

{ #category : #'*Spec2-Morphic-Examples' }
SpImagePresenter classSide >> example [

	<sampleInstance>
	^ self new
		  image: (self iconNamed: #pharoBig);
		  open
]
