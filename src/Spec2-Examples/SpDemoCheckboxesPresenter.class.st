"
This demo shows differenty styles of check boxes.
"
Class {
	#name : #SpDemoCheckboxesPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'checkboxNormal',
		'checkboxDisabled',
		'checkboxWithHelp',
		'checkboxWithLabelOnLeft',
		'checkboxExample'
	],
	#category : #'Spec2-Examples-Demo-Checkboxes'
}

{ #category : #accessing }
SpDemoCheckboxesPresenter >> checkboxDisabled [
	^ checkboxDisabled
]

{ #category : #accessing }
SpDemoCheckboxesPresenter >> checkboxDisabled: anObject [
	checkboxDisabled := anObject
]

{ #category : #accessing }
SpDemoCheckboxesPresenter >> checkboxNormal [
	^ checkboxNormal
]

{ #category : #accessing }
SpDemoCheckboxesPresenter >> checkboxNormal: anObject [
	checkboxNormal := anObject
]

{ #category : #accessing }
SpDemoCheckboxesPresenter >> checkboxWithHelp [
	^ checkboxWithHelp
]

{ #category : #accessing }
SpDemoCheckboxesPresenter >> checkboxWithHelp: anObject [
	checkboxWithHelp := anObject
]

{ #category : #accessing }
SpDemoCheckboxesPresenter >> checkboxWithLabelOnLeft [
	^ checkboxWithLabelOnLeft
]

{ #category : #accessing }
SpDemoCheckboxesPresenter >> checkboxWithLabelOnLeft: anObject [
	checkboxWithLabelOnLeft := anObject
]

{ #category : #layout }
SpDemoCheckboxesPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		add: (SpBoxLayout newTopToBottom
			add: checkboxNormal;
			add: checkboxDisabled;
			add: checkboxWithHelp;
			yourself);
		add: checkboxExample;
		yourself
]

{ #category : #initialization }
SpDemoCheckboxesPresenter >> initializePresenters [

	checkboxNormal  := self newCheckBox
		label: 'normal'.
	checkboxDisabled := self newCheckBox 
		label: 'disabled';
		disable;
		yourself.
	checkboxWithHelp := self newCheckBox 
		label: 'with help';
		help: 'this is checkbox with help';
		yourself.
	checkboxExample := self instantiate: SpCheckBoxExample.

																						
]
