Extension { #name : #SpLinkPresenter }

{ #category : #'*Spec-Examples' }
SpLinkPresenter class >> example [
	<sampleInstance>
	^ self new
		url: 'https://pharo.org';
		label: 'Pharo website';
		extent: 200 @ 20;
		openWithSpec;
		yourself
]
