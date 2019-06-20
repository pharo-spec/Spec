Extension { #name : #SpDatePresenter }

{ #category : #'*Spec-Examples' }
SpDatePresenter class >> example [
	<sampleInstance>
	^ self new openDialogWithSpec
]

{ #category : #'*Spec-Examples' }
SpDatePresenter class >> exampleModal [
	<sampleInstance>
	^ self new openDialogWithSpec modalRelativeTo: self currentWorld
]
