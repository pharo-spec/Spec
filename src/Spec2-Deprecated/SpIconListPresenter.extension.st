Extension { #name : #SpIconListPresenter }

{ #category : #'*Spec2-Deprecated' }
SpIconListPresenter class >> example [
	<sampleInstance>
	| example |
	example := self new.
	example
		icons: [ :e | example iconNamed: #forwardIcon ];
		items: (1 to: 10) asArray;
		openWithSpec.
	^ example
]

{ #category : #'*Spec2-Deprecated' }
SpIconListPresenter class >> isDeprecated [
	^ true
]
