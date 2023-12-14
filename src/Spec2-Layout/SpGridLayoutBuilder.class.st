"
I build Grid Layouts using a fluent API.
You do not need to give elements position on the grid but you rather add elements in order (raw by raw) and you tell me when I need to go to next raw.

Example:
SpGridLayout build: [ :builder |
	builder
		add: 'Name:';
		add: #nameTextInput;
		nextRow;
		add: 'Surname:';
		add: #surnameTextInput;
		nextRow ]
"
Class {
	#name : 'SpGridLayoutBuilder',
	#superclass : 'Object',
	#instVars : [
		'currentColumn',
		'currentRow',
		'layout'
	],
	#category : 'Spec2-Layout-Grid',
	#package : 'Spec2-Layout',
	#tag : 'Grid'
}

{ #category : 'instance creation' }
SpGridLayoutBuilder class >> on: aGridLayout [

	^ self basicNew
		initializeLayout: aGridLayout;
		yourself
]

{ #category : 'api' }
SpGridLayoutBuilder >> add: aChild [
	layout add: aChild at: self nextColumn @ self currentRow.
]

{ #category : 'api' }
SpGridLayoutBuilder >> add: aChild span: spanPoint [
			
	layout add: aChild at: self nextColumn @ self currentRow span: spanPoint.
]

{ #category : 'api' }
SpGridLayoutBuilder >> beColumnHomogeneous [

	layout columnHomogeneous: true
]

{ #category : 'api' }
SpGridLayoutBuilder >> beColumnNotHomogeneous [

	layout columnHomogeneous: false
]

{ #category : 'api' }
SpGridLayoutBuilder >> beRowHomogeneous [

	layout rowHomogeneous: true
]

{ #category : 'api' }
SpGridLayoutBuilder >> beRowNotHomogeneous [

	layout rowHomogeneous: false
]

{ #category : 'api' }
SpGridLayoutBuilder >> borderWidth: anInteger [
	layout borderWidth: anInteger
]

{ #category : 'api' }
SpGridLayoutBuilder >> column: aNumber expand: aBoolean [

	layout column: aNumber expand: aBoolean
]

{ #category : 'api' }
SpGridLayoutBuilder >> column: aNumber withConstraints: aBlock [

	layout column: aNumber withConstraints: aBlock
]

{ #category : 'api' }
SpGridLayoutBuilder >> columnSpacing: aNumber [

	layout columnSpacing: aNumber
]

{ #category : 'private' }
SpGridLayoutBuilder >> currentRow [
	^ currentRow
]

{ #category : 'initialization' }
SpGridLayoutBuilder >> initialize [ 

	super initialize.
	currentRow := 1.
	self resetCurrentColumn.
]

{ #category : 'initialization' }
SpGridLayoutBuilder >> initializeLayout: aGridLayout [

	layout := aGridLayout.
	self initialize
]

{ #category : 'accessing' }
SpGridLayoutBuilder >> layout [
	^ layout 
]

{ #category : 'private' }
SpGridLayoutBuilder >> nextColumn [
	^ currentColumn := currentColumn + 1
]

{ #category : 'api' }
SpGridLayoutBuilder >> nextRow [
	currentRow := currentRow + 1.
	self resetCurrentColumn.
]

{ #category : 'private' }
SpGridLayoutBuilder >> resetCurrentColumn [
	currentColumn := 0.
]

{ #category : 'api' }
SpGridLayoutBuilder >> row: aNumber expand: aBoolean [

	layout row: aNumber expand: aBoolean
]

{ #category : 'api' }
SpGridLayoutBuilder >> row: aNumber withConstraints: aBlock [

	layout row: aNumber withConstraints: aBlock
]

{ #category : 'api' }
SpGridLayoutBuilder >> rowSpacing: aNumber [

	layout rowSpacing: aNumber
]
