Class {
	#name : 'SpColumnAlignment',
	#superclass : 'Object',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'Spec2-Core-Widgets-Table',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Table'
}

{ #category : 'accessing' }
SpColumnAlignment class >> center [

	^ SpColumnAlignmentCenter uniqueInstance
]

{ #category : 'accessing' }
SpColumnAlignment class >> left [

	^ SpColumnAlignmentLeft uniqueInstance
]

{ #category : 'instance creation' }
SpColumnAlignment class >> new [

	self error: 'Use #uniqueInstance'
]

{ #category : 'accessing' }
SpColumnAlignment class >> right [

	^ SpColumnAlignmentRight uniqueInstance
]

{ #category : 'instance creation' }
SpColumnAlignment class >> uniqueInstance [

	self = SpColumnAlignment 
		ifTrue: [ self error: 'I am an abstract class. Use one of my children.' ].
	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]
