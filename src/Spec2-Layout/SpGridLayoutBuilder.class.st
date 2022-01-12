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
	#name : #SpGridLayoutBuilder,
	#superclass : #Object,
	#instVars : [
		'currentColumn',
		'currentRow',
		'layout'
	],
	#category : #'Spec2-Layout-Grid'
}

{ #category : #'instance creation' }
SpGridLayoutBuilder class >> on: aGridLayout [

	^ self basicNew
		initializeLayout: aGridLayout;
		yourself
]

{ #category : #api }
SpGridLayoutBuilder >> add: aChild [
	layout add: aChild at: self nextColumn @ self currentRow.
]

{ #category : #private }
SpGridLayoutBuilder >> currentRow [
	^ currentRow
]

{ #category : #initialization }
SpGridLayoutBuilder >> initialize [ 

	super initialize.
	currentRow := 1.
	self resetCurrentColumn.
]

{ #category : #initialization }
SpGridLayoutBuilder >> initializeLayout: aGridLayout [

	layout := aGridLayout.
	self initialize
]

{ #category : #accessing }
SpGridLayoutBuilder >> layout [
	^ layout 
]

{ #category : #private }
SpGridLayoutBuilder >> nextColumn [
	^ currentColumn := currentColumn + 1
]

{ #category : #api }
SpGridLayoutBuilder >> nextRow [
	currentRow := currentRow + 1.
	self resetCurrentColumn.
]

{ #category : #private }
SpGridLayoutBuilder >> resetCurrentColumn [
	currentColumn := 0.
]
