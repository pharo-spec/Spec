Class {
	#name : #SpAthensPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#traits : 'SpTContextMenu',
	#classTraits : 'SpTContextMenu classTrait',
	#instVars : [
		'#drawBlock => SpObservableSlot',
		'#surfaceExtent => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets-Athens'
}

{ #category : #specs }
SpAthensPresenter class >> adapterName [
	^ #AthensStaticAdapter
]

{ #category : #initialization }
SpAthensPresenter >> drawBlock [
	^ drawBlock
]

{ #category : #initialization }
SpAthensPresenter >> drawBlock: aBlock [
	drawBlock := aBlock.
	
]

{ #category : #initialization }
SpAthensPresenter >> initialize [
	super initialize.
]

{ #category : #initialization }
SpAthensPresenter >> surfaceExtent [
	^ surfaceExtent
]

{ #category : #initialization }
SpAthensPresenter >> surfaceExtent: anExtent [
	surfaceExtent := anExtent.
	
]

{ #category : #'API -Events' }
SpAthensPresenter >> whenDrawBlockChangedDo: aBlockClosure [ 
	self property: #drawBlock whenChangedDo: aBlockClosure 
]

{ #category : #'API -Events' }
SpAthensPresenter >> whenExtentChangedDo: aBlockClosure [ 
	self property: #surfaceExtent whenChangedDo: aBlockClosure 
]
