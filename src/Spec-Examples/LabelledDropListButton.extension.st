Extension { #name : #LabelledDropListButton }

{ #category : #'*Spec-Examples' }
LabelledDropListButton class >> example [
	<sampleInstance>
	| example |
	example := self abstractExample.
	example button label: 'I am a button'.
	example
		items: {'item 1' . 'item 2'};
		displayBlock: [ :item | item asString ];
		extent: 550 @ 50;
		openWithSpec.
	^ example
]

{ #category : #'*Spec-Examples' }
LabelledDropListButton class >> exampleUse [
	<sampleInstance>
	| example |
	example := self new.
	example button label: 'Add'.
	example label: 'Compose your team';
		displayBlock: [ :item | item asString ];
		items: {'Swordian' . 'Gardian' . 'Wizard' . 'Sniper'};
		extent: 300 @ 120;
		title: 'LabelDropButton example of use';
		openWithSpec: #labelTop.
	^ example
]
