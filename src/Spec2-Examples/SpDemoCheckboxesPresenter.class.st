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

{ #category : #layout }
SpDemoCheckboxesPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: checkboxExample expand: false;
		add: checkboxNormal;
		add: checkboxDisabled;
		add: checkboxWithHelp;
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
