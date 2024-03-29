"
Abstract superclass for item positioning. Each subclass should only have one instance.

The default item positioning is left.

  	ITItemPosition default
	ITItemPosition right
	ITItemPosition left
"
Class {
	#name : 'SpToolbarItemPosition',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'accessing' }
SpToolbarItemPosition class >> default [
	^ self left	
]

{ #category : 'accessing' }
SpToolbarItemPosition class >> left [
	^ SpToolbarItemLeftPosition uniqueInstance
	
]

{ #category : 'instance creation' }
SpToolbarItemPosition class >> new [
	self error: 'Use uniqueInstance'
]

{ #category : 'accessing' }
SpToolbarItemPosition class >> right [
	^ SpToolbarItemRightPosition uniqueInstance
	
]

{ #category : 'instance creation' }
SpToolbarItemPosition class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ]
]

{ #category : 'accessing' }
SpToolbarItemPosition >> addItem: anObject into: aToolbar [
	self subclassResponsibility
]
