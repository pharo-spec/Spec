"
A TextFieldExample is a simple example of how to use TextFields.
"
Class {
	#name : #SpTextFieldExample,
	#superclass : #SpPresenter,
	#instVars : [
		'methodBrowser',
		'textField'
	],
	#category : #'Spec2-Examples-Standalone'
}

{ #category : #examples }
SpTextFieldExample class >> example [

	<sampleInstance>
	^ self new open
]

{ #category : #specs }
SpTextFieldExample class >> title [

	^ 'Text Field Example'
]

{ #category : #initialization }
SpTextFieldExample >> connectPresenters [
	
	textField whenTextChangedDo: [ :text | 
		self class environment
			at: text asSymbol
			ifPresent: [ :class | methodBrowser messages: class methods ]
			ifAbsent: [ methodBrowser messages: #() ] ]
]

{ #category : #layout }
SpTextFieldExample >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: textField expand: false;
		  add: methodBrowser;
		  yourself
]

{ #category : #api }
SpTextFieldExample >> initialExtent [
	^ 900@550
]

{ #category : #initialization }
SpTextFieldExample >> initializePresenters [

	methodBrowser := self instantiate: SpDemoMessageBrowser.

	textField := self newTextInput.
	textField
		placeholder: 'Enter a class name';
		removeEntryCompletion
]

{ #category : #accessing }
SpTextFieldExample >> methodBrowser [

	^ methodBrowser
]

{ #category : #accessing }
SpTextFieldExample >> textField [

	^ textField
]
