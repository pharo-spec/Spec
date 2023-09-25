Class {
	#name : 'SpHorizontalPanedLayoutTest',
	#superclass : 'SpPanedLayoutTest',
	#category : 'Spec2-Tests-Layout',
	#package : 'Spec2-Tests',
	#tag : 'Layout'
}

{ #category : 'initialization' }
SpHorizontalPanedLayoutTest >> initializeTestedInstance [

	layout := SpPanedLayout newLeftToRight.
	presenter layout: layout
]
