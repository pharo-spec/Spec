"
I am a grid layout. 
As my name tells, I can place my elements in a grid, following some constraints: 

- a position is mandatory
- a span can be added if desired

A grid layout is typically used while doing ""form-like"" presenters, for example, we can 
do something like this: 

```
--------------------------
| Name:      | ######### |
--------------------------
| Password:  | ######### |
--------------------------
|       [Accept] [Cancel]| 
--------------------------
```

You can achieve this in several ways, but a simple one would be where `#nameText` refer to a getter method.


```
SpGridLayout new 
	add: 'Name:' 			at: 1@1;
	add: #nameText 			at: 2@1
	add: 'Password:' 		at: 1@2;
	add: #passwordText 	at: 2@2;
	add: (SpBoxLayout newHorizontal
			addLast: #acceptButton;
			addLast: #cancelButton;
			yourself)
		at: 1@3 
		span: 2@1;
	yourself
```

Note that using a string as in 
```
SpecGridLayout new 
	add: 'Name:' 			at: 1@1;
```
automatically add a label. 


In addition as you can see that we can have other layouts taking several cell elements as in the following where the SpBoxLayout is taking two cells of the grid.
```
add: (SpBoxLayout newHorizontal
			addLast: #acceptButton;
			addLast: #cancelButton;
			yourself)
		at: 1@3 
		span: 2@1;
```




"
Class {
	#name : #SpGridLayout,
	#superclass : #SpExecutableLayout,
	#instVars : [
		'borderWidth',
		'columnSpacing',
		'rowSpacing',
		'rowConstraints',
		'columnConstraints',
		'columnHomogeneous',
		'rowHomogeneous',
		'childrenByPosition'
	],
	#category : #'Spec2-Layout-Grid'
}

{ #category : #'instance creation' }
SpGridLayout class >> build: aBlock [

	^ self new 
		build: aBlock;
		yourself
]

{ #category : #initialization }
SpGridLayout class >> defaultBorderWidth [

	^ 20
]

{ #category : #initialization }
SpGridLayout class >> defaultColumnSpacing [

	^ 10
]

{ #category : #initialization }
SpGridLayout class >> defaultRowSpacing [

	^ 5
]

{ #category : #private }
SpGridLayout >> adapterName [

	^ #GridAdapter
]

{ #category : #'api - adding' }
SpGridLayout >> add: aName at: aPoint [

	^ self 
		add: aName 
		at: aPoint
		span: 1@1
]

{ #category : #'api - adding' }
SpGridLayout >> add: aName at: aPoint span: spanPoint [

	childrenByPosition at: aPoint ifPresent: [ :e |
		"Remove element at the same position"
		self remove: e ].

	^ self 
		add: aName 
		withConstraints: [ :constraints |
			constraints 
				position: aPoint;
				span: spanPoint ]
]

{ #category : #'api - adding' }
SpGridLayout >> add: aChild withConstraints: aBlock [

	super add: aChild withConstraints: aBlock.
	childrenByPosition at: (children at: aChild) position put: aChild.
	self announceChildAdded: aChild.
]

{ #category : #api }
SpGridLayout >> beColumnHomogeneous [

	self columnHomogeneous: true
]

{ #category : #api }
SpGridLayout >> beColumnNotHomogeneous [

	self columnHomogeneous: false
]

{ #category : #api }
SpGridLayout >> beRowHomogeneous [

	self rowHomogeneous: true
]

{ #category : #api }
SpGridLayout >> beRowNotHomogeneous [

	self rowHomogeneous: false
]

{ #category : #api }
SpGridLayout >> borderWidth [

	^ borderWidth ifNil: [ self class defaultBorderWidth ]
]

{ #category : #api }
SpGridLayout >> borderWidth: anObject [
	borderWidth := anObject
]

{ #category : #api }
SpGridLayout >> build: aBlock [

	aBlock value: (SpGridLayoutBuilder on: self)
]

{ #category : #api }
SpGridLayout >> children [

	^ children
]

{ #category : #api }
SpGridLayout >> column: aNumber withConstraints: aBlock [
	| constraints |

	constraints := SpGridAxisConstraints new.
	aBlock value: constraints.
	columnConstraints 
		at: aNumber
		put: constraints
]

{ #category : #api }
SpGridLayout >> columnConstraintsAt: columnNumber [

	^ columnConstraints 
		at: columnNumber 
		ifAbsent: [ nil ]
]

{ #category : #private }
SpGridLayout >> columnHomogeneous: anObject [
	columnHomogeneous := anObject
]

{ #category : #api }
SpGridLayout >> columnSpacing [

	^ columnSpacing ifNil: [ self class defaultColumnSpacing ]
]

{ #category : #api }
SpGridLayout >> columnSpacing: anObject [
	columnSpacing := anObject
]

{ #category : #private }
SpGridLayout >> constraintsClass [

	^ SpGridConstraints
]

{ #category : #initialization }
SpGridLayout >> initialize [ 

	super initialize.
	self beColumnHomogeneous.
	self beRowNotHomogeneous.
	columnConstraints := Dictionary new.
	rowConstraints := Dictionary new.
	childrenByPosition := Dictionary new.
]

{ #category : #testing }
SpGridLayout >> isColumnHomogeneous [
	^ columnHomogeneous
]

{ #category : #testing }
SpGridLayout >> isRowHomogeneous [
	^ rowHomogeneous
]

{ #category : #'api - adding' }
SpGridLayout >> replaceAt: aPoint with: aPresenter [
	"This is just a synonym of SpGridLayout>>#add:at:, added for clarity"
	
	^ self 
		add: aPresenter
		at: aPoint
]

{ #category : #api }
SpGridLayout >> row: aNumber withConstraints: aBlock [
	| constraints |

	constraints := SpGridAxisConstraints new.
	aBlock value: constraints.
	rowConstraints 
		at: aNumber
		put: constraints
]

{ #category : #api }
SpGridLayout >> rowConstraintsAt: rowNumber [

	^ rowConstraints 
		at: rowNumber 
		ifAbsent: [ nil ]
]

{ #category : #private }
SpGridLayout >> rowHomogeneous: anObject [
	rowHomogeneous := anObject
]

{ #category : #api }
SpGridLayout >> rowSpacing [

	^ rowSpacing ifNil: [ self class defaultRowSpacing ]
]

{ #category : #api }
SpGridLayout >> rowSpacing: anObject [
	rowSpacing := anObject
]
