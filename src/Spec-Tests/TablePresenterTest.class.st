Class {
	#name : #TablePresenterTest,
	#superclass : #SpecTestCase,
	#instVars : [
		'presenter'
	],
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
TablePresenterTest >> classToTest [
	
	^ TablePresenter
]

{ #category : #tests }
TablePresenterTest >> setUp [
	super setUp.
	presenter := TablePresenter new.
]

{ #category : #tests }
TablePresenterTest >> testSmokeOpenEmptyTablePresenter [

	window := presenter openWithSpec
]

{ #category : #tests }
TablePresenterTest >> testSmokeOpenTablePresenterWithItemsButNoColumns [

	window := presenter
		items: #(1 2 3);
		openWithSpec.
]
