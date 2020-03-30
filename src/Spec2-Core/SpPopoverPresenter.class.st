"
I'm a popover popover. 
I will be relative to my owner, but I can be shown pointing to a particular place (see popup, and popupPointingTo:)
Also, I can be show at the top, left, bottom or right of the owner or rectangle to point.

self example
"
Class {
	#name : #SpPopoverPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'presenter',
		'position'
	],
	#category : #'Spec2-Core-Widgets'
}

{ #category : #specs }
SpPopoverPresenter class >> adapterName [

	^ #PopoverAdapter
]

{ #category : #api }
SpPopoverPresenter >> bePositionDown [

	position := SpPopoverPosition down
]

{ #category : #api }
SpPopoverPresenter >> bePositionLeft [

	position := SpPopoverPosition left
]

{ #category : #api }
SpPopoverPresenter >> bePositionRight [

	position := SpPopoverPosition right
]

{ #category : #api }
SpPopoverPresenter >> bePositionUp [

	position := SpPopoverPosition up
]

{ #category : #initialization }
SpPopoverPresenter >> initialize [
	super initialize.
]

{ #category : #api }
SpPopoverPresenter >> popup [
		
	self withAdapterDo: [ :anAdapter |
		anAdapter popup ]
]

{ #category : #api }
SpPopoverPresenter >> popupPointingTo: aRectangle [
		
	self withAdapterDo: [ :anAdapter |
		anAdapter popupPointingTo: aRectangle ]
]

{ #category : #api }
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
