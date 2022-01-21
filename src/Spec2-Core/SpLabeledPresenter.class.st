"
Description
--------------------

A LabelledPresenter is a simple presenter to display an input with a label and optionnaly a description.

Example:

	self instantiate: (LabelledPresenter label: 'Email' input: self newTextInput description: 'Email adress to use to send activation and informations emails.')
"
Class {
	#name : #SpLabeledPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'input',
		'descriptionPresenter',
		'labelPresenter'
	],
	#category : #'Spec2-Core-Widgets'
}

{ #category : #layout }
SpLabeledPresenter class >> defaultLayout [
	^ SpBoxLayout newLeftToRight
		add: #labelPresenter withConstraints: [ :constraints | constraints width: self labelWidth ];
		add:
			(SpBoxLayout newTopToBottom
				add: #input withConstraints: [ :constraints | constraints height: self inputTextHeight ];
				add: #descriptionPresenter withConstraints: [ :constraints | constraints height: self inputTextHeight ]);
		yourself
]

{ #category : #'instance creation' }
SpLabeledPresenter class >> label: aString input: aPresenter [
	^ self label: aString input: aPresenter description: nil
]

{ #category : #'instance creation' }
SpLabeledPresenter class >> label: aString input: aPresenter description: anotherString [
	^ self new
		label: aString;
		input: aPresenter;
		description: anotherString;
		yourself
]

{ #category : #accessing }
SpLabeledPresenter >> description: aString [
	aString ifNil: [ ^ self ].
	
	descriptionPresenter := self newLabel
		addStyle: 'italic';
		label: aString;
		yourself
]

{ #category : #accessing }
SpLabeledPresenter >> descriptionPresenter [
	^ descriptionPresenter
]

{ #category : #accessing }
SpLabeledPresenter >> descriptionPresenter: anObject [
	descriptionPresenter := anObject
]

{ #category : #initialization }
SpLabeledPresenter >> initializePresenters [
	labelPresenter := self newLabel.
	descriptionPresenter :=  self newNullPresenter. "By default it is null"
]

{ #category : #accessing }
SpLabeledPresenter >> input [
	^ input
]

{ #category : #accessing }
SpLabeledPresenter >> input: anObject [
	input := anObject.
	self focusOrder add: input
]

{ #category : #accessing }
SpLabeledPresenter >> label: aString [
	labelPresenter label: aString
]

{ #category : #accessing }
SpLabeledPresenter >> labelPresenter [
	^ labelPresenter
]

{ #category : #accessing }
SpLabeledPresenter >> labelPresenter: anObject [
	labelPresenter := anObject
]
