"
Spec presenter example entry point which contains a component list:

- A left-side component list acts as a ""selector"" (class `SpComponentListSelectorExample`) and it can hold Spec presenters as items in its list.
- A right-side list acts as a ""destination"" which is a normal list, configured in `#connectPresenters` to be updated when the selected item changes

"
Class {
	#name : 'SpComponentListSelectionExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'selectorPresenter',
		'destinationPresenter'
	],
	#category : 'Spec2-Tests-Utils',
	#package : 'Spec2-Tests',
	#tag : 'Utils'
}

{ #category : 'instance creation' }
SpComponentListSelectionExample class >> open [
	<example>
	^ self new open
]

{ #category : 'initialization' }
SpComponentListSelectionExample >> connectPresenters [ 

	selectorPresenter
		transmitTo: destinationPresenter 
		transform: [ : item | { item label asNumber . (item label asNumber * 2) }  ]
]

{ #category : 'layout' }
SpComponentListSelectionExample >> defaultLayout [ 

	^ SpBoxLayout newLeftToRight 
		add: selectorPresenter;
		add: destinationPresenter;
		yourself
]

{ #category : 'accessing' }
SpComponentListSelectionExample >> destinationPresenter [

	^ destinationPresenter
]

{ #category : 'initialization' }
SpComponentListSelectionExample >> initializePresenters [

	selectorPresenter := self instantiate: SpComponentListSelectorExample on: self.
	destinationPresenter := self newList.
]

{ #category : 'accessing' }
SpComponentListSelectionExample >> selectorPresenter [

	^ selectorPresenter
]
