Class {
	#name : #SpGotFocusEvent,
	#superclass : #SpBaseEvent,
	#category : #'Spec2-Core-Base-Event'
}

{ #category : #installing }
SpGotFocusEvent >> installOn: anAdapter target: aWidget [

	anAdapter installGotFocusEvent: self to: aWidget
]
