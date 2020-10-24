"
A presenter that chains a miller list (`SpMillerColumnPresenter`) along with a paginator (`SpPaginatorPresenter`). 
This is the most common usage of paginator, and there are several places where we want to use a miller list with pagination and this common presenter will be provifing basic functionality pre-made for consumption.
"
Class {
	#name : #SpMillerPaginatorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'millerList',
		'paginator'
	],
	#category : #'Spec2-Core-Widgets-Advanced'
}

{ #category : #initialization }
SpMillerPaginatorPresenter >> initializePresenters [

	self layout: (SpBoxLayout newVertical
		spacing: 3;
		add: (millerList := self instantiate: SpMillerColumnPresenter);
		add: (SpBoxLayout newHorizontal
				hAlignCenter; 
				add: (paginator := self instantiate: SpPaginatorPresenter) expand: false;
				yourself)
			expand: false;
		yourself).
		
	millerList withoutHorizontalScrollBar.
	millerList whenColumnsChangedDo: [ :page | self updatePaginator: page ].
	paginator chainTo: millerList.
	self updatePaginator: 1
]

{ #category : #api }
SpMillerPaginatorPresenter >> millerListPresenter [

	^ millerList
]

{ #category : #api }
SpMillerPaginatorPresenter >> pages [

	^ millerList pages
]

{ #category : #api }
SpMillerPaginatorPresenter >> paginatorPresenter [

	^ paginator
]

{ #category : #private }
SpMillerPaginatorPresenter >> updatePaginator: pageSelected [

	paginator pages: millerList pages.
	paginator selectPage: pageSelected.
	
	millerList pages size > 1 
		ifTrue: [ paginator show ]
		ifFalse: [ paginator hide ]
]
