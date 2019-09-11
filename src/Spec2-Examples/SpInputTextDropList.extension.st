Extension { #name : #SpInputTextDropList }

{ #category : #'*Spec2-Examples' }
SpInputTextDropList classSide >> example [
	<sampleInstance>
	| example |
	example := self new
		placeholder: 'a Number';
		display: [ :item | item asString ];
		items: {'Potatoes' . 'Carrots' . 'Onions'};
		extent: 350 @ 50;
		openWithSpec;
		yourself.
	example withWindowDo: [ :window | window title: 'InputTextDropList example' ].
	^ example
]
