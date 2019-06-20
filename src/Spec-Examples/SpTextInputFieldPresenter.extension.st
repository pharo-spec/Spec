Extension { #name : #SpTextInputFieldPresenter }

{ #category : #'*Spec-Examples' }
SpTextInputFieldPresenter class >> example [
	<sampleInstance>
	^ self new
		extent: 300 @ 25;
		openWithSpec;
		placeholder: 'This is a ghost';
		text: 'This is a text'
]
