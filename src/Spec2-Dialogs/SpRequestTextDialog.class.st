"
A dialog to request multiple lines of text to users.
"
Class {
	#name : 'SpRequestTextDialog',
	#superclass : 'SpRequestDialog',
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'accessing' }
SpRequestTextDialog class >> defaultExtent [

	^ 450@300
]

{ #category : 'documentation' }
SpRequestTextDialog class >> documentFactoryMethodSelector [
	
	^ #newRequestText
]

{ #category : 'examples' }
SpRequestTextDialog class >> example [

	^ super example
]

{ #category : 'examples' }
SpRequestTextDialog class >> exampleModal [

	^ super exampleModal
]

{ #category : 'layout' }
SpRequestTextDialog >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 5;
	  	add: (SpBoxLayout newLeftToRight
				add: (SpBoxLayout newTopToBottom
						vAlignStart;
						add: image;
						yourself)
					expand: false;
				add: label expand: true;
				yourself)
	  		height: self calculateLabelHeight;
		add: textInput expand: true;
		add: errorLabel expand: false;
		yourself
]

{ #category : 'initialization' }
SpRequestTextDialog >> initializePresenters [

	image := self newImage image: (self iconNamed: #question).
	label := self newDialogLabel.
	textInput := self newTextInput.
	errorLabel := self newLabel.
	
	label hide
]
