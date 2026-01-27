Class {
	#name : 'SpSuspendableSlot',
	#superclass : 'ObservableSlot',
	#category : 'Spec2-Core-Widgets-Table',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Table'
}

{ #category : 'initialization' }
SpSuspendableSlot >> initialize: anObject [

	^ self 
		object: anObject 
		instVarAt: index 
		put: SpSuspendableValueHolder new
]
