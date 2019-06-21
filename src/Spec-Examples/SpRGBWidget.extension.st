Extension { #name : #SpRGBWidget }

{ #category : #'*Spec-Examples' }
SpRGBWidget class >> example [
	<sampleInstance>
	| example |
	example := self new
		extent: 300 @ 250;
		openDialogWithSpec;
		yourself.
	example withWindowDo: [ :window | window title: 'RGBWidget example' ].
	^ example
]
