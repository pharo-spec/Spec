"
Represents an item example to display a class name and its comment in a Spec component list.
"
Class {
	#name : 'SpTransmissionComponentItemExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'classNamePresenter',
		'classCommentPresenter'
	],
	#category : 'Spec2-Examples-Demo-ComponentList',
	#package : 'Spec2-Examples',
	#tag : 'Demo-ComponentList'
}

{ #category : 'layout' }
SpTransmissionComponentItemExample >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: classNamePresenter expand: false fill: false padding: 5;
		add: classCommentPresenter expand: true fill: true padding: 5;
		yourself.
]

{ #category : 'initialization' }
SpTransmissionComponentItemExample >> initializePresenters [

	classNamePresenter := self newLabel 
		label: owner className;
		addStyle: 'gray';
		yourself.
	classCommentPresenter := self newText text: owner comment.
]

{ #category : 'accessing - model' }
SpTransmissionComponentItemExample >> setModelBeforeInitialization: aClass [

	owner := aClass
]
