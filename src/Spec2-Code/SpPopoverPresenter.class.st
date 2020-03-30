Class {
	#name : #SpPopoverPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'#presenter => SpObservableSlot'
	],
	#category : #'Spec2-Code'
}

{ #category : #specs }
SpPopoverPresenter class >> adapterName [

	^ #PopoverAdapter
]

{ #category : #api }
SpPopoverPresenter >> popupPointingTo: aRectangle [
		
	self withAdapterDo: [ :anAdapter |
		anAdapter popupPointingTo: aRectangle ]
]

{ #category : #'as yet unclassified' }
SpPopoverPresenter >> presenter [
	^ presenter
]

{ #category : #api }
SpPopoverPresenter >> presenter: aPresenter [

	aPresenter owner: self.
	presenter := aPresenter
]

{ #category : #'api-events' }
SpPopoverPresenter >> whenPresenterChangedDo: aBlock [

	self property: #presenter whenChangedDo: aBlock
]
