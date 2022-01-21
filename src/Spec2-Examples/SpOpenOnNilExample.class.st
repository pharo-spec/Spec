"
I am the component of DynamycSpecExample used for nil.

self example

I display simply an TextInputFieldPresenter, disable to don't be edditable by the user.
"
Class {
	#name : #SpOpenOnNilExample,
	#superclass : #SpPresenter,
	#instVars : [
		'text'
	],
	#category : #'Spec2-Examples-Wrapper'
}

{ #category : #layout }
SpOpenOnNilExample class >> defaultLayout [
	^ SpBoxLayout newTopToBottom
		add: #text withConstraints: [ :constraints | constraints height: 25 ];
		yourself
]

{ #category : #examples }
SpOpenOnNilExample class >> example [

	<sampleInstance>
	^ self new
		  extent: 200 @ 100;
		  open;
		  yourself
]

{ #category : #initialization }
SpOpenOnNilExample >> initialize: anInteger [
	text label: anInteger asString
]

{ #category : #initialization }
SpOpenOnNilExample >> initializePresenters [
	text := self instantiate: SpTextInputFieldPresenter.
	text
		text: 'Object is nil';
		enabled: false.
]

{ #category : #accessing }
SpOpenOnNilExample >> text [
	^ text
]

{ #category : #accessing }
SpOpenOnNilExample >> title [
	^ 'OpenOnNilExample'
]
