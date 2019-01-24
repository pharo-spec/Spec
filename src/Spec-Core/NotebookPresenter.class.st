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

{ #category : #accessing }
NotebookPresenter >> pages [ 

	^ pagesHolder value
]

{ #category : #accessing }
NotebookPresenter >> pages: aCollection [

	pagesHolder value: aCollection
]

{ #category : #private }
NotebookPresenter >> pagesChanged [

	self changed: #updatePages
]
