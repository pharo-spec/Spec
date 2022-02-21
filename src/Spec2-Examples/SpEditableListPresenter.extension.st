Extension { #name : #SpEditableListPresenter }

{ #category : #'*Spec2-Examples' }
SpEditableListPresenter class >> example [

	<sampleInstance>
	| presenter |
	presenter := self new
		             items: self selectors asOrderedCollection;
		             addItemBlock: [ 1 ];
		             open;
		             yourself.

	presenter withWindowDo: [ :w | w title: 'Selectors list' ].

	^ presenter
]

{ #category : #'*Spec2-Examples' }
SpEditableListPresenter class >> exampleWithoutOrderingBars [

	<sampleInstance>
	| presenter |
	presenter := self new
		             items: self selectors asOrderedCollection;
		             addItemBlock: [ 1 ];
		             openWithLayout: self withoutOrderingBar;
		             yourself.

	presenter withWindowDo: [ :w | w title: 'Selectors list' ].

	^ presenter
]
