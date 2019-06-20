Extension { #name : #SpDiffPresenter }

{ #category : #'*Spec-Examples' }
SpDiffPresenter class >> exampleWithOptions [
	"
	self exampleWithOptions
	"
	<sampleInstance>
	^ self new
		showOptions: true;
		leftText: (True >> #and:) sourceCode;
		rightText: (True >> #or:) sourceCode;
		contextClass: True;
		openWithSpec
]

{ #category : #'*Spec-Examples' }
SpDiffPresenter class >> exampleWithoutOptions [
	"
	self exampleWithoutOptions
	"
	<sampleInstance>
	
	^ self new
		showOptions: false;
		leftText: 'Old text';
		rightText: 'New text';
		openWithSpec

]
