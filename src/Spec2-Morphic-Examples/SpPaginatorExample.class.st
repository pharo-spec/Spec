Class {
	#name : #SpPaginatorExample,
	#superclass : #SpPresenter,
	#instVars : [
		'millerList',
		'paginator'
	],
	#category : #'Spec2-Morphic-Examples'
}

{ #category : #initialization }
SpPaginatorExample >> initializePresenters [ 
	<script: 'self new openWithSpec'>

	layout := SpBoxLayout newVertical
		spacing: 5;
		add: (millerList := self instantiate: SpMillerColumnPresenter);
		add: (SpBoxLayout newHorizontal
				hAlignCenter; 
				add: (paginator := self newMorph) expand: false;
				yourself)
			expand: false;
		yourself.
		
	millerList withoutHorizontalScrollBar.
	paginator 
		addStyle: 'paginator';
		morph: SpPaginatorMorph new.
		
	paginator morph 
		whenSelectedPageChangedDo: [ :pageNumber | 
			millerList selectColumn: pageNumber ].
		
	1 to: 10 do: [ :index | | presenter |
		presenter := SpListPresenter new
			items: (1 to: index);
			yourself.
		millerList addPresenter: presenter.
		paginator morph addPageFor: presenter ]
]
