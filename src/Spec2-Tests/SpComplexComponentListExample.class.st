Class {
	#name : 'SpComplexComponentListExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'leftPresenter',
		'rightPresenter',
		'toolbarPresenter'
	],
	#category : 'Spec2-Tests-Utils',
	#package : 'Spec2-Tests',
	#tag : 'Utils'
}

{ #category : 'instance creation' }
SpComplexComponentListExample class >> open [
	<example>
	^ self new open
]

{ #category : 'initialization' }
SpComplexComponentListExample >> connectPresenters [ 

	leftPresenter
		transmitTo: rightPresenter 
		transform: [ : item | { item label asNumber . (item label asNumber * 2) }  ]
]

{ #category : 'layout' }
SpComplexComponentListExample >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: toolbarPresenter expand: false;
		add: (SpBoxLayout newLeftToRight 
			add: leftPresenter;
			add: rightPresenter;
			yourself);
		yourself.
]

{ #category : 'initialization' }
SpComplexComponentListExample >> initializePresenters [

	toolbarPresenter := self newToolbar.
	leftPresenter := self instantiate: SpComplexComponentListLeftExample on: self.
	rightPresenter := self instantiate: SpComplexComponentListRightExample on: self.
]
