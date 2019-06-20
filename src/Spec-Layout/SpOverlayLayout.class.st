Class {
	#name : #SpOverlayLayout,
	#superclass : #SpExecutableLayout,
	#category : #'Spec-Layout-Overlay'
}

{ #category : #private }
SpOverlayLayout >> adapterName [
	
	^ #OverlayAdapter
]

{ #category : #accessing }
SpOverlayLayout >> add: aName [

	self
		add: aName 
		withConstraints: [ :constraints | ]
]

{ #category : #private }
SpOverlayLayout >> constraintsClass [
	
	^ SpOverlayConstraints
]
