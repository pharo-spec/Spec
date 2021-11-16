Extension { #name : #SpPopoverPresenter }

{ #category : #'*Spec2-Morphic-Backend-Tests' }
SpPopoverPresenter class >> sampleInstanceForTest [

	^ super sampleInstanceForTest
		relativeTo: (SpButtonPresenter new
			buildWithSpec; 
			yourself);
		presenter: SpLabelPresenter new;
		yourself
]
