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
		'#presenter => SpObservableSlot',
		'#position'
	],
	#category : #'Spec2-Core-Widgets'
}

{ #category : #specs }
SpPopoverPresenter class >> adapterName [

	^ #PopoverAdapter
]

{ #category : #api }
SpPopoverPresenter >> bePositionBottom [

	position := SpPopoverPosition bottom
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
SpPopoverPresenter >> bePositionTop [

	position := SpPopoverPosition top
]

{ #category : #api }
SpPopoverPresenter >> dismiss [ 

	^ self withAdapterDo: [ :anAdapter | anAdapter dismiss ]
]

{ #category : #initialization }
SpPopoverPresenter >> initialize [

	super initialize.
	self bePositionBottom
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
SpPopoverPresenter >> position [

	^ position
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
