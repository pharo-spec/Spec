Class {
	#name : #NotebookPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'pagesHolder'
	],
	#category : #'Spec-Core-Widgets-Tab'
}

{ #category : #specs }
NotebookPresenter class >> adapterName [

	^ #NotebookAdapter
]

{ #category : #accessing }
NotebookPresenter >> addPage: aPage [

	aPage owner: self.
	pagesHolder add: aPage
]

{ #category : #initialization }
NotebookPresenter >> initialize [

	super initialize.
	pagesHolder := OrderedCollection new asValueHolder.
	pagesHolder whenChangedDo: [ self pagesChanged ]
]

{ #category : #accessing }
NotebookPresenter >> pageAt: index [

	^ self pages at: index
]

{ #category : #private }
NotebookPresenter >> pageChanged: aPage [ 

	self changed: #updatePage: with: { aPage }
]

{ #category : #accessing }
NotebookPresenter >> pages [ 

	^ pagesHolder value
]

{ #category : #accessing }
NotebookPresenter >> pages: aCollection [

	aCollection do: [ :each |
		self addPage: each ]
]

{ #category : #private }
NotebookPresenter >> pagesChanged [

	self changed: #updatePages
]
