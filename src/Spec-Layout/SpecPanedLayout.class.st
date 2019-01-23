"
I'm a Paned Layout.
A paned layout is like a Box Layout (it places childen in vertical or horizontal fashion), but it will add a splitter in between, that user can drag to resize the panel.
In exchange, a paned layout can have just two children.
"
Class {
	#name : #SpecPanedLayout,
	#superclass : #SpecExecutableLayout,
	#instVars : [
		'direction'
	],
	#category : #'Spec-Layout-Paned'
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
	
	children size = 2 ifTrue: [ 
		self error: 'You can not add more than two paned presenters.' ].

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
