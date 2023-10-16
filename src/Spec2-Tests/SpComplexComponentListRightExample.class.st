Class {
	#name : 'SpComplexComponentListRightExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'componentListPresenter',
		'pageTitle'
	],
	#category : 'Spec2-Tests-Utils',
	#package : 'Spec2-Tests',
	#tag : 'Utils'
}

{ #category : 'transmission' }
SpComplexComponentListRightExample >> defaultInputPort [ 

	^ SpListItemsPort newPresenter: componentListPresenter

]

{ #category : 'layout' }
SpComplexComponentListRightExample >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: pageTitle expand: false;
		add: componentListPresenter;
		yourself.


]

{ #category : 'initialization' }
SpComplexComponentListRightExample >> initializePresenters [ 

	pageTitle := self newLabel.
	componentListPresenter := self newComponentList.

]
