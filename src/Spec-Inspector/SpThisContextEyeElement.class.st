"
This eye element is used in the right panel of the debugger to show thiscontext instead of self as a label
"
Class {
	#name : #SpThisContextEyeElement,
	#superclass : #SpSelfEyeElement,
	#category : #'Spec-Inspector-Element'
}

{ #category : #accessing }
SpThisContextEyeElement >> accessorCode [
	^ super label
]

{ #category : #accessing }
SpThisContextEyeElement >> label [
	^ 'thisContext'
]
