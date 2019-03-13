Class {
	#name : #AthensAnimatedPresenter,
	#superclass : #AthensStaticPresenter,
	#traits : 'TSpecObservable',
	#classTraits : 'TSpecObservable classTrait',
	#instVars : [
		'timeline',
		'updateBlock'
	],
	#category : #'Spec-Core-Widgets-Athens'
}

{ #category : #specs }
AthensAnimatedPresenter class >> adapterName [
	^ #AthensAnimatedAdapter
]

{ #category : #initialization }
AthensAnimatedPresenter >> drawBlock: aBlock [
	super drawBlock: [ : canvas | 
		self updateModelToMoment: timeline ticks.
		aBlock cull: canvas.	
	 ]
	
]

{ #category : #initialization }
AthensAnimatedPresenter >> initialize [
	self class initializeSlots: self.
	super initialize.
	updateBlock := [  ].
	timeline := Timeline new.
	timeline whenTickDo: [ :tick | self updatePresenter ]
]

{ #category : #initialization }
AthensAnimatedPresenter >> tick [
	timeline tick
]

{ #category : #initialization }
AthensAnimatedPresenter >> updateBlock [
	^ updateBlock
]

{ #category : #initialization }
AthensAnimatedPresenter >> updateBlock: aBlock [
	updateBlock := aBlock
]

{ #category : #initialization }
AthensAnimatedPresenter >> updateModelToMoment: aTick [
	updateBlock cull: aTick
]
