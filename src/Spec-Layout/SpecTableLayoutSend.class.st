"
A SpecTableLayoutSend is a spec layout action used when a selector is sent to the layout. It differs from SpecLayoutSend by being independent from specific layout.

"
Class {
	#name : #SpecTableLayoutSend,
	#superclass : #AbstractSpecLayoutAction,
	#category : #'Spec-Layout-Actions'
}

{ #category : #'instance creation' }
SpecTableLayoutSend class >> selector: selector [

	^ self new
		selector: selector;
		yourself
]
