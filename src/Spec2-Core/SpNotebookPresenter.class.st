"
I'm a presenter for a tabbed notebook container.
"
Class {
	#name : #SpNotebookPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#pagesHolder',
		'#selectedPage => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets-Tab'
}

{ #category : #specs }
SpNotebookPresenter class >> adapterName [

	^ #NotebookAdapter
]

{ #category : #api }
SpNotebookPresenter >> addPage: aPage [

	aPage owner: self.
	pagesHolder add: aPage
]

{ #category : #initialization }
SpNotebookPresenter >> initialize [
	super initialize.
	pagesHolder := OrderedCollection new asValueHolder.

	pagesHolder whenChangedDo: [ self pagesChanged ]
]

{ #category : #api }
SpNotebookPresenter >> pageAt: index [

	^ self pages at: index
]

{ #category : #private }
SpNotebookPresenter >> pageTitleChanged: aPage [ 

	self changed: #updatePageTitle: with: { aPage }
]

{ #category : #api }
SpNotebookPresenter >> pages [ 

	^ pagesHolder value
]

{ #category : #api }
SpNotebookPresenter >> pages: aCollection [

	aCollection do: [ :each | each owner: self ].
	pagesHolder rawValue: aCollection.
	pagesHolder valueChanged: nil
]

{ #category : #private }
SpNotebookPresenter >> pagesChanged [

	self changed: #updatePages
]

{ #category : #removing }
SpNotebookPresenter >> removeAll [

	pagesHolder removeAll
]

{ #category : #removing }
SpNotebookPresenter >> removePage: aPage [

	pagesHolder remove: aPage
]

{ #category : #removing }
SpNotebookPresenter >> removePageAt: anIndex [

	pagesHolder removeAt: anIndex
]

{ #category : #api }
SpNotebookPresenter >> resetAllPageContents [

	self pages do: #resetContent
]

{ #category : #api }
SpNotebookPresenter >> selectPage: aPage [

	aPage = self selectedPage ifTrue: [ ^ self ].
	selectedPage := aPage
]

{ #category : #api }
SpNotebookPresenter >> selectPageIndex: aNumber [
	self selectPage: (self pages at: aNumber)
]

{ #category : #api }
SpNotebookPresenter >> selectedPage [

	^ selectedPage
]

{ #category : #api }
SpNotebookPresenter >> selectedPageIndex [
	| page |
	
	page := self selectedPage.
	page ifNil: [ ^ 0 ].
	
	^ self pages indexOf: page
]

{ #category : #'private-traversing' }
SpNotebookPresenter >> traverseInFocusOrderDo: aBlock excluding: excludes [

	excludes add: self.
	aBlock value: self.
	
	self selectedPage ifNil: [ ^ self ].
	self selectedPage activePresenter
		traverseInFocusOrderDo: aBlock 
		excluding: excludes
]

{ #category : #private }
SpNotebookPresenter >> updatePageContent: aPage [

	self changed: #updatePageContent: with: { aPage }
]

{ #category : #'api-events' }
SpNotebookPresenter >> whenPageAddedDo: aBlock [

	pagesHolder whenAddedDo: aBlock
]

{ #category : #'api-events' }
SpNotebookPresenter >> whenPageRemovedDo: aBlock [

	pagesHolder whenRemovedDo: aBlock
]

{ #category : #'api-events' }
SpNotebookPresenter >> whenPagesChangedDo: aBlock [

	pagesHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpNotebookPresenter >> whenSelectedPageChangedDo: aBlock [

	self 
		property: #selectedPage 
		whenChangedDo: aBlock
]
