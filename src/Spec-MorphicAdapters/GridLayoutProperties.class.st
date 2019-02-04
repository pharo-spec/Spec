Class {
	#name : #GridLayoutProperties,
	#superclass : #LayoutProperties,
	#instVars : [
		'position',
		'span'
	],
	#category : #'Spec-MorphicAdapters-Layout'
}

{ #category : #'instance creation' }
GridLayoutProperties class >> at: aPoint [

	^ self new 
		position: aPoint;
		yourself
]

{ #category : #'instance creation' }
GridLayoutProperties class >> at: aPoint span: spanPoint [

	^ self new 
		position: aPoint;
		span: spanPoint;
		yourself
]

{ #category : #accessing }
GridLayoutProperties >> column [ 

	^ self position x
]

{ #category : #accessing }
GridLayoutProperties >> columnSpan [ 

	^ self span x
]

{ #category : #initialization }
GridLayoutProperties >> initialize [ 
	
	super initialize.
	self hResizing: #spaceFill.
	self vResizing: #spaceFill.
	self span: 1@1
]

{ #category : #accessing }
GridLayoutProperties >> position [
	^ position
]

{ #category : #accessing }
GridLayoutProperties >> position: anObject [
	position := anObject
]

{ #category : #accessing }
GridLayoutProperties >> row [ 

	^ self position y
]

{ #category : #accessing }
GridLayoutProperties >> rowSpan [ 

	^ self span y
]

{ #category : #accessing }
GridLayoutProperties >> span [
	^ span
]

{ #category : #accessing }
GridLayoutProperties >> span: anObject [
	span := anObject
]
