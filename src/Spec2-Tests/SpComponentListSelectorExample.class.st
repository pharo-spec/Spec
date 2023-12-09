"
This example acts as a selector of presenter items, this is, each of the items is a Spec component obtained through `#asPresenter`.
"
Class {
	#name : 'SpComponentListSelectorExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'componentListPresenter'
	],
	#category : 'Spec2-Tests-Utils',
	#package : 'Spec2-Tests',
	#tag : 'Utils'
}

{ #category : 'layout' }
SpComponentListSelectorExample >> defaultLayout [ 

	^ SpBoxLayout newTopToBottom 
		add: componentListPresenter expand: true;
		yourself.
]

{ #category : 'ports' }
SpComponentListSelectorExample >> defaultOutputPort [ 

	^ componentListPresenter defaultOutputPort
]

{ #category : 'initialization' }
SpComponentListSelectorExample >> initializePresenters [

	componentListPresenter := self newComponentList
		items: ((10 to: 20) asArray collect: #asPresenter);
		yourself.
]

{ #category : 'api' }
SpComponentListSelectorExample >> selectIndex: anIndex [

	componentListPresenter selectIndex: anIndex
]
