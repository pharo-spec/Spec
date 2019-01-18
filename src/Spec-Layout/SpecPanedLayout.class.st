Class {
	#name : #SpecPanedLayout,
	#superclass : #SpecExecutableLayout,
	#instVars : [
		'direction'
	],
	#category : #'Spec-Layout-Box'
}

{ #category : #'instance creation' }
SpecPanedLayout class >> new [ 

	self error: 'Use one of my siblings'
]

{ #category : #'instance creation' }
SpecPanedLayout class >> newHorizontal [ 

	^ super new beHorizontal
]

{ #category : #'instance creation' }
SpecPanedLayout class >> newVertical [ 

	^ super new beVertical
]

{ #category : #private }
SpecPanedLayout >> adapterName [

	^ #PanedAdapter
]

{ #category : #adding }
SpecPanedLayout >> add: aName [

	self 
		add: aName 
		withConstraints: [ :constraints | ]
]

{ #category : #adding }
SpecPanedLayout >> add: aName withConstraints: aBlock [
	| constraints |
	
	constraints := self constraintsClass new.
	aBlock value: constraints.
	children 
		at: aName 
		put: constraints
]

{ #category : #initialization }
SpecPanedLayout >> beHorizontal [

	direction := SpecLayoutDirection horizontal
]

{ #category : #initialization }
SpecPanedLayout >> beVertical [

	direction := SpecLayoutDirection vertical
]

{ #category : #private }
SpecPanedLayout >> constraintsClass [

	^ SpecPanedConstraints
]

{ #category : #accessing }
SpecPanedLayout >> direction [ 

	^ direction
]

{ #category : #initialization }
SpecPanedLayout >> initialize [

	super initialize.
]

{ #category : #testing }
SpecPanedLayout >> isHorizontal [ 

	^ self direction = SpecLayoutDirection horizontal
]

{ #category : #testing }
SpecPanedLayout >> isVertical [ 

	^ self direction = SpecLayoutDirection vertical
]
