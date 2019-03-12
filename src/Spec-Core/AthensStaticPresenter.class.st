Class {
	#name : #AthensStaticPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'#drawBlock => SpecObservableSlot'
	],
	#category : #'Spec-Core-Widgets-Athens'
}

{ #category : #specs }
AthensStaticPresenter class >> adapterName [
	^ #AthensStaticAdapter
]

{ #category : #initialization }
AthensStaticPresenter >> drawBlock: aBlock [
	drawBlock := aBlock.
	
]

{ #category : #initialization }
AthensStaticPresenter >> drawsBlock [
	^ drawBlock
]

{ #category : #initialization }
AthensStaticPresenter >> initialize [
	self class initializeSlots: self.
	super initialize.
	
]
