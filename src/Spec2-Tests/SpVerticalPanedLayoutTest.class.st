Class {
	#name : 'SpVerticalPanedLayoutTest',
	#superclass : 'SpPanedLayoutTest',
	#category : 'Spec2-Tests-Layout',
	#package : 'Spec2-Tests',
	#tag : 'Layout'
}

{ #category : 'initialization' }
SpVerticalPanedLayoutTest >> initializeTestedInstance [

	layout := SpPanedLayout newTopToBottom.
	presenter layout: layout
]
