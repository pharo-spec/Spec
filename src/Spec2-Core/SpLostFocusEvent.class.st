Class {
	#name : #SpLostFocusEvent,
	#superclass : #SpBaseEvent,
	#category : #'Spec2-Core-Base-Event'
}

{ #category : #installing }
SpLostFocusEvent >> installOn: anAdapter target: aWidget [

	anAdapter installLostFocusEvent: self to: aWidget
]
