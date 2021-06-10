Class {
	#name : #SpOverlayLayoutTest,
	#superclass : #SpLayoutTest,
	#category : #'Spec2-Tests-Layout'
}

{ #category : #initialization }
SpOverlayLayoutTest >> initializeTestedInstance [

	layout := SpOverlayLayout new.
	presenter layout: layout
]

{ #category : #tests }
SpOverlayLayoutTest >> testLayoutWithOneElementIsNotEmpty [

	layout child: SpButtonPresenter new.
	self deny: layout isEmpty
]

{ #category : #tests }
SpOverlayLayoutTest >> testLayoutWithOverlayWidgetIsNotEmpty [

	layout addOverlay: SpButtonPresenter new.
	self deny: layout isEmpty
]

{ #category : #tests }
SpOverlayLayoutTest >> testRemoveElementFromLayoutTakesItOut [

	| element |
	layout child: (element := SpButtonPresenter new).
	layout remove: element.
	self assert: layout isEmpty
]

{ #category : #tests }
SpOverlayLayoutTest >> testRemoveOverlayFromLayoutTakesItOut [

	| element |
	layout addOverlay: (element := SpButtonPresenter new).
	layout remove: element.
	self assert: layout isEmpty
]

{ #category : #tests }
SpOverlayLayoutTest >> testReplaceElementKeepsSingleElement [

	| replacement |
	layout child: SpButtonPresenter new.
	layout child: (replacement := SpButtonPresenter new).
	self assert: layout children size equals: 1
]
