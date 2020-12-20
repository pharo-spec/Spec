Class {
	#name : #SpTabLayout,
	#superclass : #SpExecutableLayout,
	#category : #'Spec2-Layout-Tab'
}

{ #category : #private }
SpTabLayout >> adapterName [

	^ #TabAdapter
]

{ #category : #accessing }
SpTabLayout >> add: aName label: aString [

	self 
		add: aName 
		withConstraints: [ :constraints | 
			constraints label: aString ]
]

{ #category : #accessing }
SpTabLayout >> add: aPresenter withConstraints: aBlock [
	
	super add: aPresenter withConstraints: aBlock.
	self announceChildAdded: aPresenter
]

{ #category : #private }
SpTabLayout >> constraintsClass [

	^ SpTabConstraints
]
