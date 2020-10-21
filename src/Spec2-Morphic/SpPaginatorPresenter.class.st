Class {
	#name : #SpPaginatorPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#visiblePages => SpObservableSlot',
		'#selectedPage => SpObservableSlot',
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
