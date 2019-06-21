Extension { #name : #SpEditableList }

{ #category : #'*Spec-Examples' }
SpEditableList class >> example [
	<sampleInstance>
	^self new
	
		title: 'Selectors list';
		list: self selectors;
	 openWithSpec
]
