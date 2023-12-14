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

{ #category : 'layout' }
SpRequestTextDialog class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 5;
		add: (SpBoxLayout newLeftToRight
				vAlignCenter;
				spacing: 5;
				add: #image expand: false;
				add: #label;
				yourself)
			expand: false;
		add: #textInput;
		yourself
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

{ #category : 'initialization' }
SpRequestTextDialog >> initializePresenters [

	image := self newImage image: (self application iconNamed: #question).
	label := self newLabel.
	textInput := self newText
]
