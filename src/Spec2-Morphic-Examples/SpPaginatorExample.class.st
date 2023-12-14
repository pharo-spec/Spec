Class {
	#name : 'SpPaginatorExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'millerList',
		'paginator'
	],
	#category : 'Spec2-Morphic-Examples',
	#package : 'Spec2-Morphic-Examples'
}

{ #category : 'layout' }
SpPaginatorExample >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 5;
		add: millerList;
		add: (SpBoxLayout newLeftToRight
				hAlignCenter; 
				add: paginator expand: false;
				yourself)
			expand: false;
		yourself
]

{ #category : 'initialization' }
SpPaginatorExample >> initializePresenters [ 
	<script: 'self new open'>

	millerList := self instantiate: SpMillerColumnPresenter.
	millerList withoutHorizontalScrollBar.

	paginator := self instantiate: SpPaginatorPresenter.		
	paginator chainTo: millerList.
	paginator visiblePages: 2
]

{ #category : 'initialization' }
SpPaginatorExample >> updatePresenter [

	1 to: 10 do: [ :index | | presenter |
		presenter := SpListPresenter new
			items: (1 to: index);
			yourself.
		millerList addPresenter: presenter.
		paginator addPage: presenter ].
	
	paginator selectPage: 1.
	millerList selectPage: 1
]
