Class {
	#name : 'SpMillerPaginatorPresenterTest',
	#superclass : 'SpSpecTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpMillerPaginatorPresenterTest >> classToTest [

	^ SpMillerPaginatorPresenter
]

{ #category : 'running' }
SpMillerPaginatorPresenterTest >> tearDown [

	presenter withWindowDo: [ :w | w close ].
	super tearDown
]

{ #category : 'tests' }
SpMillerPaginatorPresenterTest >> testHeightOfSubpresenters [

	| button layout container |
	layout := SpBoxLayout newTopToBottom
		add: presenter height: 300;
		yourself.
	presenter millerListPresenter presenterBlock: [ :page | SpButtonPresenter new label: '2'; yourself ].
	button := SpButtonPresenter new label: '1'; yourself.
	presenter millerListPresenter addPresenter: button.
	container := SpPresenter new layout: layout; yourself.
	container open.
	button click. "Add a second page so that the paginator appears."
	WorldMorph doOneCycle. "Ensure that the height below is updated."
	self assert: presenter millerListPresenter adapter widget height equals: 280.
	self assert: presenter paginatorPresenter adapter widget height equals: 20
]
