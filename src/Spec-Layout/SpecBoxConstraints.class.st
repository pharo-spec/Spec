Class {
	#name : #SpecBoxConstraints,
	#superclass : #Object,
	#instVars : [
		'expand',
		'fill',
		'padding',
		'minWidth',
		'minHeight',
		'placedAtStart'
	],
	#category : #'Spec-Layout-Box'
}

{ #category : #'as yet unclassified' }
SpecBoxConstraints class >> defaultExpand [

	^ true
]

{ #category : #'as yet unclassified' }
SpecBoxConstraints class >> defaultFill [

	^ true
]

{ #category : #'as yet unclassified' }
SpecBoxConstraints class >> defaultPadding [ 

	^ 0
]

{ #category : #accessing }
SpecBoxConstraints >> bePlacedAtEnd [

	placedAtStart := false
]

{ #category : #accessing }
SpecBoxConstraints >> bePlacedAtStart [

	placedAtStart := true
]

{ #category : #accessing }
SpecBoxConstraints >> expand: aBoolean [

	expand := aBoolean
]

{ #category : #accessing }
SpecBoxConstraints >> fill: aBoolean [

	fill := aBoolean
]

{ #category : #testing }
SpecBoxConstraints >> initialize [ 

	super initialize.
	self bePlacedAtStart
]

{ #category : #testing }
SpecBoxConstraints >> isExpand [
	^ expand ifNil: [ self class defaultExpand ]
]

{ #category : #testing }
SpecBoxConstraints >> isFill [
	^ fill ifNil: [ self class defaultFill ]
]

{ #category : #testing }
SpecBoxConstraints >> isPlacedAtStart [
	
	^ placedAtStart
]

{ #category : #accessing }
SpecBoxConstraints >> minHeight [
	"Minimum height of component.
	 this just has sense in the case of expand=false"

	^ minHeight
]

{ #category : #accessing }
SpecBoxConstraints >> minHeight: anObject [
	minHeight := anObject
]

{ #category : #accessing }
SpecBoxConstraints >> minWidth [
	"Minimum height of component.
	 this just has sense in the case of expand=false"

	^ minWidth
]

{ #category : #accessing }
SpecBoxConstraints >> minWidth: anObject [
	minWidth := anObject
]

{ #category : #accessing }
SpecBoxConstraints >> padding [
	^ padding ifNil: [ self class defaultPadding ]
]

{ #category : #accessing }
SpecBoxConstraints >> padding: aNumber [

	padding := aNumber
]
