Class {
	#name : #SpecGridLayout,
	#superclass : #SpecExecutableLayout,
	#instVars : [
		'borderWidth',
		'columnSpacing',
		'rowSpacing'
	],
	#category : #'Spec-Layout-Grid'
}

{ #category : #initialization }
SpecGridLayout class >> defaultBorderWidth [

	^ 20
]

{ #category : #initialization }
SpecGridLayout class >> defaultColumnSpacing [

	^ 10
]

{ #category : #initialization }
SpecGridLayout class >> defaultRowSpacing [

	^ 5
]

{ #category : #private }
SpecGridLayout >> adapterName [

	^ #GridAdapter
]

{ #category : #adding }
SpecGridLayout >> add: aName at: aPoint [

	^ self 
		add: aName 
		at: aPoint
		span: 1@1
]

{ #category : #adding }
SpecGridLayout >> add: aName at: aPoint span: spanPoint [

	^ self 
		add: aName 
		withConstraints: [ :constraints |
			constraints 
				position: aPoint;
				span: spanPoint ]
]

{ #category : #accessing }
SpecGridLayout >> borderWidth [

	^ borderWidth ifNil: [ self class defaultBorderWidth ]
]

{ #category : #accessing }
SpecGridLayout >> borderWidth: anObject [
	borderWidth := anObject
]

{ #category : #accessing }
SpecGridLayout >> children [

	^ children
]

{ #category : #accessing }
SpecGridLayout >> columnSpacing [

	^ columnSpacing ifNil: [ self class defaultColumnSpacing ]
]

{ #category : #accessing }
SpecGridLayout >> columnSpacing: anObject [
	columnSpacing := anObject
]

{ #category : #private }
SpecGridLayout >> constraintsClass [

	^ SpecGridConstraints
]

{ #category : #accessing }
SpecGridLayout >> rowSpacing [

	^ rowSpacing ifNil: [ self class defaultRowSpacing ]
]

{ #category : #accessing }
SpecGridLayout >> rowSpacing: anObject [
	rowSpacing := anObject
]
