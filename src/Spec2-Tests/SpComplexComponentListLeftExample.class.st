Class {
	#name : 'SpComplexComponentListLeftExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'componentListPresenter'
	],
	#category : 'Spec2-Tests-Utils',
	#package : 'Spec2-Tests',
	#tag : 'Utils'
}

{ #category : 'layout' }
SpComplexComponentListLeftExample >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: componentListPresenter expand: true;
		yourself.
]

{ #category : 'ports' }
SpComplexComponentListLeftExample >> defaultOutputPort [ 

	^ componentListPresenter 
]

{ #category : 'initialization' }
SpComplexComponentListLeftExample >> initializePresenters [

	componentListPresenter := self newComponentList
		items: ((10 to: 20) asArray collect: #asPresenter);
		yourself.
]
