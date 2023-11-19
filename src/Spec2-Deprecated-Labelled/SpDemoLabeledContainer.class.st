"
A component that should encapsulate a form part with a specific label
"
Class {
	#name : 'SpDemoLabeledContainer',
	#superclass : 'SpLabelledContainer',
	#category : 'Spec2-Deprecated-Labelled',
	#package : 'Spec2-Deprecated-Labelled'
}

{ #category : 'specs' }
SpDemoLabeledContainer class >> defaultSpec [
	^ SpBoxLayout newTopToBottom
		add: #label withConstraints: [ :constraints | constraints height: self inputTextHeight ];
		add: #subwidget;
		yourself
]

{ #category : 'accessing' }
SpDemoLabeledContainer >> label: aString [

	label label: ' - ', aString, ' - '
]
