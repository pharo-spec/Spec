Class {
	#name : 'SpSuspendableValueHolder',
	#superclass : 'ObservableValueHolder',
	#instVars : [
		'suspendedCount'
	],
	#category : 'Spec2-Core-Widgets-Table',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Table'
}

{ #category : 'suspending' }
SpSuspendableValueHolder >> suspendChangedDuring: aBlock [

	suspendedCount ifNil: [ suspendedCount := 0 ].
	suspendedCount := suspendedCount + 1.
	aBlock ensure: [
		suspendedCount := suspendedCount - 1 ]
]

{ #category : 'accessing' }
SpSuspendableValueHolder >> valueChanged: oldValue [

	(suspendedCount isNotNil and: [ suspendedCount > 0 ]) ifTrue: [ ^ self ].
	super valueChanged: oldValue
]
