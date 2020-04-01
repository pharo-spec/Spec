"
A presenter with a list and a label used to test Spec transmission.
Selected element in the list is transmitted to the label using #asString to transform it.
"
Class {
	#name : #SpTransmissionTestPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'list',
		'label'
	],
	#category : #'Spec2-Transmission-Tests'
}

{ #category : #specs }
SpTransmissionTestPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #list;
		add: #label expand: false;
		yourself
]

{ #category : #specs }
SpTransmissionTestPresenter class >> example [
	^ self new 
		openWithSpec;
		yourself
]

{ #category : #initialization }
SpTransmissionTestPresenter >> connectPresenters [
	list transmitTo: label transform: [ :item | item asString ]
]

{ #category : #initialization }
SpTransmissionTestPresenter >> initializePresenters [
	list := SpTablePresenter new
		items: (1 to: 5) asOrderedCollection;
		yourself.
	label := SpLabelPresenter new.
]

{ #category : #accessing }
SpTransmissionTestPresenter >> items: aCollection [
	list items: aCollection
]

{ #category : #accessing }
SpTransmissionTestPresenter >> label [
	^ label label
]

{ #category : #selecting }
SpTransmissionTestPresenter >> selectIndex: anIndex [
	list selectIndex: anIndex
]

{ #category : #selecting }
SpTransmissionTestPresenter >> selection [
	^ list selection
]

{ #category : #selecting }
SpTransmissionTestPresenter >> unselectAll [
	list unselectAll
]
