Extension { #name : #LabelledInputTextDropList }

{ #category : #'*Spec-Examples' }
LabelledInputTextDropList class >> example [
	<sampleInstance>
	| example |
	example := self abstractExample.
	example
		placeholder: 'ghost text';
		items: {'item 1' . 'item 2'};
		displayBlock: [ :item | item asString ];
		extent: 450 @ 50;
		openWithSpec.
	^ example
]
