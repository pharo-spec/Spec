Class {
	#name : #SpOverlayConstraints,
	#superclass : #SpLayoutConstraints,
	#instVars : [
		'overlay'
	],
	#category : #'Spec-Layout-Overlay'
}

{ #category : #accessing }
SpOverlayConstraints >> beOverlay [
	
	^ overlay := true
]

{ #category : #testing }
SpOverlayConstraints >> isOverlay [
	
	^ overlay = true
]
