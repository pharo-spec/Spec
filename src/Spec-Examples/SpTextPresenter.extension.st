Extension { #name : #SpTextPresenter }

{ #category : #'*Spec-Examples' }
SpTextPresenter class >> example [
	<sampleInstance>
	^ self new
	 openWithSpec;
		text:
			'This is a test.
If this had been an actual emergency...'

]
