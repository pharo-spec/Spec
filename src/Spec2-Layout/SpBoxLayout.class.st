"
A layout that will arrange presenters in a box, vertically (top to bottom) or horizontally (left to right).
Elements can be added at the begining or at the end of the box (see `SpBoxLayout>>#add:` and `SpBoxLayout>>#addLast:` method families).
"
Class {
	#name : #SpBoxLayout,
	#superclass : #SpDirectionableLayout,
	#traits : 'SpTAlignable',
	#classTraits : 'SpTAlignable classTrait',
	#instVars : [
		'spacing',
		'borderWidth',
		'homogeneous'
	],
	#category : #'Spec2-Layout-Box'
}

{ #category : #private }
SpBoxLayout >> adapterName [

	^ #BoxAdapter
]

{ #category : #adding }
SpBoxLayout >> add: aName [

	self 
		add: aName 
		withConstraints: [ :constraints | ]
]

{ #category : #adding }
SpBoxLayout >> add: aName expand: shouldExpand [

	^ self 
		add: aName 
		withConstraints: [ :constraints | 
			constraints expand: shouldExpand ]
]

{ #category : #adding }
SpBoxLayout >> add: aName expand: shouldExpand fill: shouldFill [

	self add: aName withConstraints: [ :constraints | 
		constraints
			expand: shouldExpand;
			fill: shouldFill ]
]

{ #category : #adding }
SpBoxLayout >> add: aName expand: shouldExpand fill: shouldFill padding: aNumber [
"
aName 		- the presenter to be added to box
expand 	- true if the new child is to be given extra space allocated to box . 
			  The extra space will be divided evenly between all children that use this option
fill 		- true if space given to child by the expand option is actually allocated to child , 
			  rather than just padding it. This parameter has no effect if expand is set to false. 
padding 	- extra space in pixels to put between this child and its neighbors, over and above 
			  the global amount specified by “spacing” property. If child is a widget at one of 
			  the reference ends of box , then padding pixels are also put between child and the
			  reference edge of box"

	self 
		add: aName 
		withConstraints: [ :constraints |
			constraints 
				expand: shouldExpand;
				fill: shouldFill; 
				padding: aNumber ]
]

{ #category : #adding }
SpBoxLayout >> add: aPresenter height: anInteger [ 
	"Add a presenter and assign a specific height. 
	 This constraint is applied just when using a Vertical (Top to Bottom) layout, 
	 otherwise is ignored.
	 Please notice that 99% of the time you DO NOT NEED (and you do not want) to use 
	 a fixed constraint like this one. 
	 Instead, consider using `SpBoxLayout>>#add:expand:` method. "

	self 
		add: aPresenter 
		withConstraints: [ :constraints | constraints height: anInteger ].
]

{ #category : #adding }
SpBoxLayout >> add: aPresenter width: anInteger [
	"Add a presenter and assign a specific width. 
	 This constraint is applied just when using an Horizontal (Left to Right) layout, 
	 otherwise is ignored.
	 Please notice that 99% of the time you DO NOT NEED (and you do not want) to use 
	 a fixed constraint like this one. 
	 Instead, consider using `SpBoxLayout>>#add:expand:` method. "

	self
		add: aPresenter
		withConstraints: [ :constraints | constraints width: anInteger ].
]

{ #category : #adding }
SpBoxLayout >> add: aPresenter withConstraints: aBlock [
	
	super add: aPresenter withConstraints: aBlock.
	self announceChildAdded: aPresenter.
]

{ #category : #adding }
SpBoxLayout >> addLast: aName [

	self 
		addLast: aName 
		withConstraints: [ :constraints | ]
]

{ #category : #adding }
SpBoxLayout >> addLast: aName expand: shouldExpand [

	self 
		addLast: aName 
		withConstraints: [ :constraints | 
			constraints expand: shouldExpand ]
]

{ #category : #adding }
SpBoxLayout >> addLast: aName expand: shouldExpand fill: shouldFill [

	self 
		addLast: aName 
	   withConstraints: [ :constraints | 
			constraints
				expand: shouldExpand;
				fill: shouldFill ]
]

{ #category : #adding }
SpBoxLayout >> addLast: aName expand: shouldExpand fill: shouldFill padding: aNumber [

	self 
		addLast: aName 
		withConstraints: [ :constraints |
			constraints 
				expand: shouldExpand;
				fill: shouldFill; 
				padding: aNumber ]
]

{ #category : #adding }
SpBoxLayout >> addLast: aName withConstraints: aBlock [

	self 
		add: aName 
		withConstraints: [ :constraints |
			constraints bePlacedAtEnd.
			aBlock value: constraints ]
]

{ #category : #accessing }
SpBoxLayout >> beHomogeneous [

	self homogeneous: true
]

{ #category : #accessing }
SpBoxLayout >> beNotHomogeneous [

	self homogeneous: false
]

{ #category : #accessing }
SpBoxLayout >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
SpBoxLayout >> borderWidth: anObject [
	borderWidth := anObject
]

{ #category : #private }
SpBoxLayout >> constraintsClass [

	^ SpBoxConstraints
]

{ #category : #accessing }
SpBoxLayout >> direction [ 

	^ direction
]

{ #category : #private }
SpBoxLayout >> homogeneous: aBoolean [

	homogeneous := aBoolean
]

{ #category : #initialization }
SpBoxLayout >> initialize [

	super initialize.
	self beNotHomogeneous.
	self spacing: 0.
	self borderWidth: 0
]

{ #category : #testing }
SpBoxLayout >> isHomogeneous [

	^ homogeneous
]

{ #category : #testing }
SpBoxLayout >> isHorizontal [ 

	^ self direction = SpLayoutDirection horizontal
]

{ #category : #testing }
SpBoxLayout >> isVertical [ 

	^ self direction = SpLayoutDirection vertical
]

{ #category : #removing }
SpBoxLayout >> removeAll [

	children removeAll.
	adapter ifNotNil: [ :anAdapter | anAdapter removeAll ]
]

{ #category : #adding }
SpBoxLayout >> replace: aPresenter with: otherPresenter [
	"Replace aPresenter with otherPresenter. 
	 Original constraints will be preserved."
	
	self 
		replace: aPresenter 
		with: otherPresenter
		withConstraints: (self constraintsFor: aPresenter)
]

{ #category : #adding }
SpBoxLayout >> replace: aPresenter with: otherPresenter withConstraints: constraints [
	"Replace aPresenter with otherPresenter"
	
	children
		replaceKey: aPresenter
		with: otherPresenter.

	self withAdapterDo: [ :anAdapter |
		anAdapter 
			replace: aPresenter 
			with: otherPresenter
			withConstraints: constraints ]
]

{ #category : #accessing }
SpBoxLayout >> spacing [
	^ spacing
]

{ #category : #accessing }
SpBoxLayout >> spacing: aNumber [

	spacing := aNumber
]
