Extension { #name : #SpDiffPresenter }

{ #category : #'*Spec2-Examples' }
SpDiffPresenter class >> exampleNavigableWithOptionsAndLabels [
	"
	self exampleNavigableWithOptionsAndLabels
	"
	<sampleInstance>
	^ self new
		showOptions: true;
		beNavigable: true;
		leftText: (True >> #and:) sourceCode;
		leftLabel: '#and: implementation';
		rightText: (True >> #or:) sourceCode;
		rightLabel: '#or: implementation';
		contextClass: True;
		open
]

{ #category : #'*Spec2-Examples' }
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
		open
]

{ #category : #'*Spec2-Examples' }
SpDiffPresenter class >> exampleWithOptionsAndLabels [
	"
	self exampleWithOptionsAndLabels
	"
	<sampleInstance>
	^ self new
		showOptions: true;
		leftText: (True >> #and:) sourceCode;
		leftLabel: '#and: implementation';
		rightText: (True >> #or:) sourceCode;
		rightLabel: '#or: implementation';
		contextClass: True;
		open
]

{ #category : #'*Spec2-Examples' }
SpDiffPresenter class >> exampleWithoutOptions [
	"
	self exampleWithoutOptions
	"
	<sampleInstance>
	
	^ self new
		showOptions: false;
		leftText: 'Old text';
		rightText: 'New text';
		open

]
