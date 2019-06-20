Class {
	#name : #SpScrollableLayout,
	#superclass : #SpExecutableLayout,
	#category : #'Spec-Layout-Scroll'
}

{ #category : #'instance creation' }
SpScrollableLayout class >> with: aSymbolOrPresenter [

	^ self new 
		add: aSymbolOrPresenter;
		yourself
]

{ #category : #private }
SpScrollableLayout >> adapterName [

	^ #ScrollableAdapter
]

{ #category : #adding }
SpScrollableLayout >> add: aName [ 
	
	self add: aName withConstraints: [ :aConstraint | ]
]

{ #category : #private }
SpScrollableLayout >> constraintsClass [

	^ SpBoxConstraints
]
