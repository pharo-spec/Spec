Class {
	#name : 'SpOverlayConstraints',
	#superclass : 'SpLayoutConstraints',
	#traits : 'SpTAlignable',
	#instVars : [
		'overlay'
	],
	#category : 'Spec2-Layout-Overlay',
	#package : 'Spec2-Layout',
	#tag : 'Overlay'
}

{ #category : 'accessing' }
SpOverlayConstraints >> beOverlay [
	
	^ overlay := true
]

{ #category : 'testing' }
SpOverlayConstraints >> isOverlay [
	
	^ overlay = true
]
