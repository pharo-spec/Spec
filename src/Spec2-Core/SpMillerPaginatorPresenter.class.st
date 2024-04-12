"
A presenter that chains a miller list (`SpMillerColumnPresenter`) along with a paginator (`SpPaginatorPresenter`). 
This is the most common usage of paginator, and there are several places where we want to use a miller list with pagination and this common presenter will be provifing basic functionality pre-made for consumption.
"
Class {
	#name : 'SpMillerPaginatorPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'millerList',
		'paginator',
		'paginatorContainerLayout'
	],
	#category : 'Spec2-Core-Widgets-Advanced',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Advanced'
}

{ #category : 'api' }
SpMillerPaginatorPresenter >> addPresenter: aPresenter [

	self millerListPresenter addPresenter: aPresenter
]

{ #category : 'private' }
SpMillerPaginatorPresenter >> basicUpdatePaginator: pageSelected [
		
	paginator ifNil: [ 
		paginator := self newPaginator.
		paginator visiblePages: millerList visiblePages.
		paginatorContainerLayout add: paginator expand: false.
		paginator chainTo: millerList ].
	paginator pages: millerList pages.
	"self selectPage: pageSelected"
]

{ #category : 'initialization' }
SpMillerPaginatorPresenter >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		add: (millerList := self instantiate: SpMillerColumnPresenter);
		add: ((paginatorContainerLayout := SpBoxLayout newLeftToRight)
				hAlignCenter; 
				yourself)
			expand: false;
		yourself).

	millerList withoutHorizontalScrollBar.
	millerList whenColumnsChangedDo: [ :page | self updatePaginator: page ].
	self updatePaginator: 1
]

{ #category : 'api' }
SpMillerPaginatorPresenter >> millerListPresenter [

	^ millerList
]

{ #category : 'private' }
SpMillerPaginatorPresenter >> newPaginator [
		
	^ self instantiate: SpPaginatorPresenter
]

{ #category : 'api' }
SpMillerPaginatorPresenter >> pages [

	^ millerList pages
]

{ #category : 'api' }
SpMillerPaginatorPresenter >> paginatorPresenter [

	^ paginator
]

{ #category : 'api' }
SpMillerPaginatorPresenter >> removeAllFrom: aPresenter [

	millerList removeAllFrom: aPresenter.
	self updatePaginator: ((millerList pages size - millerList visiblePages + 1) max: 1)
]

{ #category : 'api' }
SpMillerPaginatorPresenter >> selectPage: aNumber [ 

	self millerListPresenter selectPage: aNumber
]

{ #category : 'api' }
SpMillerPaginatorPresenter >> spacing: aNumber [

	self millerListPresenter spacing: aNumber
]

{ #category : 'private' }
SpMillerPaginatorPresenter >> updatePaginator: pageSelected [

	millerList pages size > 1 
		ifTrue: [ 
			"add a paginator, chained to the miller list"
			self basicUpdatePaginator: pageSelected ]
		ifFalse: [
			"we do not want the paginator, let's remove it"
			paginatorContainerLayout removeAll. 
			paginator := nil ]
]

{ #category : 'api' }
SpMillerPaginatorPresenter >> visiblePages: aNumber [

	self millerListPresenter visiblePages: 1.
	self paginatorPresenter ifNotNil: [ :aPaginator | aPaginator visiblePages: 1 ]
]
