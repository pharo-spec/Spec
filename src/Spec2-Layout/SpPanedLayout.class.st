"
A layout with two adjustable panels separated by a draggable splitter.

A paned layout manages exactly two children (first and second).
The position and sizing behavior of the panes is controlled by `#positionOfSlider:`:

- Values with absolute magnitude < 1 (e.g. 0.3, 30 percent, -0.2) define proportional splits that resize dynamically when the container is resized.
- Values with absolute magnitude >= 1 (e.g. 200, -200) define fixed pixel sizes that do not resize with the window.
- Positive values anchor the fixed/proportional constraint to the start pane (left or top).
- Negative values anchor the fixed/proportional constraint to the end pane (right or bottom).
"
Class {
	#name : 'SpPanedLayout',
	#superclass : 'SpDirectionableLayout',
	#instVars : [
		'childrenByPosition',
		'positionOfSlider'
	],
	#category : 'Spec2-Layout-Paned',
	#package : 'Spec2-Layout',
	#tag : 'Paned'
}

{ #category : 'private' }
SpPanedLayout >> adapterName [

	^ #PanedAdapter
]

{ #category : 'api - adding' }
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

{ #category : 'api - adding' }
SpPanedLayout >> add: aPresenterLayoutOrSymbol layout: aSelector [
	"Adds `aPresenterLayoutOrSymbol` to the list of presenters to be arranged in the layout, setting
	 also the layout to use with the added presenter.
	 `aPresenterLayoutOrSymbol` can be
		- any instance of `SpPresenter` hierarchy,
		- another layout or
		- a Symbol, matching the name of the instance variable who will contain the element to add.
	`aSelector` is a selector that has to be in the class side of `aPresenterLayoutOrSymbol` instance, and it will answer the layout to use."

	^ self
		add: aPresenterLayoutOrSymbol
		withConstraints: [ :constraints |
			constraints spec: aSelector ]
]

{ #category : 'private' }
SpPanedLayout >> add: aChild withConstraints: aBlock [
	self add: aChild withConstraints: aBlock place: children size + 1
]

{ #category : 'private' }
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

{ #category : 'api' }
SpPanedLayout >> children [

	^ childrenByPosition reject: #isNil
]

{ #category : 'private' }
SpPanedLayout >> constraintsClass [

	^ SpPanedConstraints
]

{ #category : 'api' }
SpPanedLayout >> direction [ 

	^ direction
]

{ #category : 'api - adding' }
SpPanedLayout >> first: aPresenterOrName [
	"Add aPresenterOrName as first element of the paned layout."
	
	self 
		add: aPresenterOrName 
		withConstraints: [ :constraints | ]
		place: 1
]

{ #category : 'initialization' }
SpPanedLayout >> initialize [

	super initialize.
	self positionOfSlider: 50 percent.
	childrenByPosition := Array new: 2
]

{ #category : 'testing' }
SpPanedLayout >> isHorizontal [ 

	^ self direction = SpLayoutDirection horizontal
]

{ #category : 'testing' }
SpPanedLayout >> isVertical [ 

	^ self direction = SpLayoutDirection vertical
]

{ #category : 'api' }
SpPanedLayout >> positionOfSlider [
	"Indicates original position of splitter. 
	 It can be nil (then it defaults to 50%).
	 It can be a percentage (e.g. 30 percent)"

	^ positionOfSlider
]

{ #category : 'api' }
SpPanedLayout >> positionOfSlider: aNumber [
	"Sets the position and sizing mode of the paned splitter:

	- Proportional sizing (|aNumber| < 1):
	    Positive (e.g. 0.3 or 30 percent): Splitted proportionally from the start (left or top).
	    Negative (e.g. -0.3 or -30 percent): Splitted proportionally from the end (right or bottom).
	    Both panes resize proportionally when the container is resized.

	- Fixed sizing (|aNumber| >= 1):
	    Positive integer (e.g. 200): Fixed offset in pixels from the start (left or top).
	      The start pane retains its fixed width/height when the window is resized.
	    Negative integer (e.g. -200): Fixed offset in pixels from the end (right or bottom).
	      The end pane retains its fixed width/height when the window is resized.

	When the user drags the splitter, the sizing mode (fixed vs proportional, start vs end) is preserved."
	positionOfSlider := aNumber
]

{ #category : 'api' }
SpPanedLayout >> remove: aPresenter ifAbsent: aBlock [

	super remove: aPresenter ifAbsent: aBlock.
	childrenByPosition 
		at: (childrenByPosition indexOf: aPresenter)
		put: nil
]

{ #category : 'api - adding' }
SpPanedLayout >> replaceFirst: aPresenter [
	"This is just a synonym of `SpPanedLayout>>#first:`, added for clarity"
	
	self first: aPresenter 
]

{ #category : 'api - adding' }
SpPanedLayout >> replaceSecond: aPresenter [
	"This is just a synonym of `SpPanedLayout>>#second:`, added for clarity"
	
	self second: aPresenter 
]

{ #category : 'api - adding' }
SpPanedLayout >> second: aPresenterOrName [
	"Add aPresenterOrName as second element of the paned layout."

	self 
		add: aPresenterOrName 
		withConstraints: [ :constraints | ]
		place: 2
]
