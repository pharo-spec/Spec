Class {
	#name : #SpRequestTextDialog,
	#superclass : #SpRequestDialog,
	#category : #'Spec2-Dialogs'
}

{ #category : #accessing }
SpRequestTextDialog class >> defaultExtent [

	^ 400@400
]

{ #category : #specs }
SpRequestTextDialog class >> defaultSpec [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add: #label expand: false;
		add: #textInput;
		yourself
]

{ #category : #initialization }
SpRequestTextDialog >> initializePresenters [

	label := self newLabel.
	textInput := (self newText
		addStyle: 'monospaceFont';
		yourself)
]
