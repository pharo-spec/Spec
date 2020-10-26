Class {
	#name : #SpPaginatorPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#visiblePages => SpObservableSlot',
		'#selectedPage => SpObservableSlot',
		'#dragging => SpObservableSlot',
		'#pagesHolder'
	],
	#category : #'Spec2-Morphic-Paginator'
}

{ #category : #specs }
SpPaginatorPresenter class >> adapterName [

	^ #PaginatorAdapter
]

{ #category : #api }
SpPaginatorPresenter >> addPage: aPresenter [
	
	pagesHolder add: aPresenter.
	self selectPage: pagesHolder size
]

{ #category : #api }
SpPaginatorPresenter >> chainTo: aPresenter [
	"It will 'chain' this paginator with `aPresenter`. 
	 In order to work, `aPresenter` needs to implement this methods: 
		- `selectPage:` to react to a page change.
		- `visiblePages:` to react to an amount of pages displayed change.
		-  `scrollByDeltaPercent:` to react to movement while displacing."
	
	self 
		whenSelectedPageChangedDo: [ :pageNumber | aPresenter selectPage: pageNumber ];
		whenVisiblePagesChangedDo: [ :aNumber | aPresenter visiblePages: aNumber ];
		whenDraggingDo: [ :deltaPercent | aPresenter scrollByDeltaPercent: deltaPercent ]
]

{ #category : #private }
SpPaginatorPresenter >> dragging: aNumber [

	dragging := aNumber
]

{ #category : #initialization }
SpPaginatorPresenter >> initialize [

	super initialize.
	pagesHolder := OrderedCollection new asValueHolder.
]

{ #category : #api }
SpPaginatorPresenter >> pages [

	^ pagesHolder
]

{ #category : #api }
SpPaginatorPresenter >> pages: aCollection [

	pagesHolder removeAll.
	aCollection do: [ :each | pagesHolder add: each ].
	
]

{ #category : #api }
SpPaginatorPresenter >> selectPage: aNumber [

	selectedPage := aNumber
]

{ #category : #api }
SpPaginatorPresenter >> visiblePages [

	^ visiblePages
]

{ #category : #api }
SpPaginatorPresenter >> visiblePages: aNumber [

	visiblePages := aNumber
]

{ #category : #'api-events' }
SpPaginatorPresenter >> whenDraggingDo: aBlock [

	self property: #dragging whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpPaginatorPresenter >> whenPageAddedDo: aBlock [

	pagesHolder whenAddedDo: aBlock
]

{ #category : #'api-events' }
SpPaginatorPresenter >> whenPageRemovedDo: aBlock [

	pagesHolder whenRemovedDo: aBlock
]

{ #category : #'api-events' }
SpPaginatorPresenter >> whenSelectedPageChangedDo: aBlock [

	self property: #selectedPage whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpPaginatorPresenter >> whenVisiblePagesChangedDo: aBlock [

	self property: #visiblePages whenChangedDo: aBlock
]
