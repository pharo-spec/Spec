"
I'm a Paned Layout.
A paned layout is like a Box Layout (it places childen in vertical or horizontal fashion), but it will add a splitter in between, that user can drag to resize the panel.
In exchange, a paned layout can have just two children.
"
Class {
	#name : #SpPanedLayout,
	#superclass : #SpDirectionableLayout,
	#instVars : [
		'childrenByPosition',
		'positionOfSlider'
	],
	#category : #'Spec2-Layout-Paned'
}

{ #category : #private }
SpPanedLayout >> adapterName [

	^ #PanedAdapter
]

{ #category : #'api - adding' }
SpPanedLayout >> add: aPresenterLayoutOrSymbol [
	"Adds `aPresenterLayoutOrSymbol` as one of the elements to put in the paned layout. 
	 Te position of the element will be calculated in order of addition (and there cannot 
	 be more than two). 
	 `aPresenterLayoutOrSymbol` can be
		- any instance of `SpPresenter` hierarchy, 
		- another layout or 
		- a Symbol, matching the name of the instance variable who will contain the element to add."

	self 
		add: aPresenterLayoutOrSymbol 
		withConstraints: [ :constraints | ]
		place: children size + 1
]

{ #category : #private }
SpPanedLayout >> add: aChild withConstraints: aBlock place: aPosition [
	"Add a child to the layout following the constraints in the block.
	The position is an integer index (1 or 2) indicating whether the child is first or last in 
	the pane.
	For a horizontal layout, index 1 means left, index 2 means right.
	For a vertical layout, index 1 means top, index 2 means bottom."
	| constraints |

	aPosition > 2 ifTrue: [ 
		self error: 'You can not add more than two paned presenters.' ].

	(childrenByPosition at: aPosition) 
		ifNotNil: [ :element | self remove: element ].

	constraints := self constraintsClass new.
	aBlock value: constraints.
	
	childrenByPosition at: aPosition put: aChild.
	
	children 
		at: aChild 
		put: constraints.
	
	self announceChildAdded: aChild.
]

{ #category : #'api - adding' }
SpPanedLayout >> addFirst: aPresenter [
	"Add aPresenter as first element of the paned layout."
	
	self 
		add: aPresenter 
		withConstraints: [ :constraints | ]
		place: 1
]

{ #category : #'api - adding' }
SpPanedLayout >> addSecond: aName [
	"Add aPresenter as second element of the paned layout."

	self 
		add: aName 
		withConstraints: [ :constraints | ]
		place: 2
]

{ #category : #api }
SpPanedLayout >> children [

	^ childrenByPosition reject: #isNil
]

{ #category : #private }
SpPanedLayout >> constraintsClass [

	^ SpPanedConstraints
]

{ #category : #api }
SpPanedLayout >> direction [ 

	^ direction
]

{ #category : #initialization }
SpPanedLayout >> initialize [

	super initialize.
	self positionOfSlider: 50 percent.
	childrenByPosition := Array new: 2
]

{ #category : #testing }
SpPanedLayout >> isHorizontal [ 

	^ self direction = SpLayoutDirection horizontal
]

{ #category : #testing }
SpPanedLayout >> isVertical [ 

	^ self direction = SpLayoutDirection vertical
]

{ #category : #api }
SpPanedLayout >> position [
	"Indicates original position of splitter. 
	 It can be nil (then it defaults to 50%).
	 It can be a percentage (e.g. 30 percent)"
	
	self
		deprecated: 'Use #positionOfSlider instead'
		transformWith: '`@receiver position' -> '`@receiver positionOfSlider'.

	^ positionOfSlider
]

{ #category : #api }
SpPanedLayout >> position: aNumber [
	"Position of the slider. 
	 - `aNumber` can be a fixed number indicating the exact position where the slider will 
	 be placed in the pane.
	 - `aNumber` can also be a fraction or a percentage, indicating the percentage position 
	 of the slider. E.g. 30 percent (0.3) indicates the slider will be place at 1/3 of the 
	 panel."

	self
		deprecated: 'Use #positionOfSlider: instead'
		transformWith: '`@receiver position: `@arg' -> '`@receiver positionOfSlider: `@arg'.
	
	positionOfSlider := aNumber
]

{ #category : #api }
SpPanedLayout >> positionOfSlider [
	"Indicates original position of splitter. 
	 It can be nil (then it defaults to 50%).
	 It can be a percentage (e.g. 30 percent)"

	^ positionOfSlider
]

{ #category : #api }
SpPanedLayout >> positionOfSlider: aNumber [
	"Position of the slider. 
	 - `aNumber` can be a fixed number indicating the exact position where the slider will 
	 be placed in the pane.
	 - `aNumber` can also be a fraction or a percentage, indicating the percentage position 
	 of the slider. E.g. 30 percent (0.3) indicates the slider will be place at 1/3 of the 
	 panel."

	positionOfSlider := aNumber
]

{ #category : #api }
SpPanedLayout >> remove: aPresenter ifAbsent: aBlock [

	super remove: aPresenter ifAbsent: aBlock.
	childrenByPosition 
		at: (childrenByPosition indexOf: aPresenter)
		put: nil
]

{ #category : #'api - adding' }
SpPanedLayout >> replaceFirst: aPresenter [
	"This is just a synonym of `SpPanedLayout>>#addFirst:`, added for clarity"
	
	self addFirst: aPresenter 
]

{ #category : #'api - adding' }
SpPanedLayout >> replaceSecond: aPresenter [
	"This is just a synonym of `SpPanedLayout>>#addSecond:`, added for clarity"
	
	self addSecond: aPresenter 
]
