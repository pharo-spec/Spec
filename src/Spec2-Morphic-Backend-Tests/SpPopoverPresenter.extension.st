Extension { #name : #SpPopoverPresenter }

{ #category : #'*Spec2-Morphic-Backend-Tests' }
SpPopoverPresenter class >> sampleInstanceForTest [

	^ super sampleInstanceForTest
		  relativeTo: (SpButtonPresenter new
				   build;
				   yourself);
		  presenter: SpLabelPresenter new;
		  yourself
]
