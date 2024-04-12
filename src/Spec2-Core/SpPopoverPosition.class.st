"
I represent the position of a popover in relation to its owner.
I am an abstract class and my children will define: top, left, bottom or right position.
"
Class {
	#name : 'SpPopoverPosition',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Spec2-Core-Support',
	#package : 'Spec2-Core',
	#tag : 'Support'
}

{ #category : 'accessing' }
SpPopoverPosition class >> bottom [

	^ SpPopoverBottomPosition uniqueInstance
]

{ #category : 'accessing' }
SpPopoverPosition class >> left [

	^ SpPopoverLeftPosition uniqueInstance
]

{ #category : 'instance creation' }
SpPopoverPosition class >> new [

	self error: 'Use #uniqueInstance'
]

{ #category : 'accessing' }
SpPopoverPosition class >> right [

	^ SpPopoverRightPosition uniqueInstance
]

{ #category : 'accessing' }
SpPopoverPosition class >> top [

	^ SpPopoverTopPosition uniqueInstance
]

{ #category : 'instance creation' }
SpPopoverPosition class >> uniqueInstance [

	self = SpPopoverPosition 
		ifTrue: [ self error: 'I''m abstract, use one of my children.' ].	
	^ uniqueInstance ifNil: [ uniqueInstance := self basicNew initialize ]
]

{ #category : 'operations' }
SpPopoverPosition >> applyTo: aWidget [

	self subclassResponsibility
]
