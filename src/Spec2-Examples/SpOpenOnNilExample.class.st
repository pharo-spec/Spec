"
I am the component of DynamycSpecExample used for nil.

self example

I display simply an TextInputFieldPresenter, disable to don't be edditable by the user.
"
Class {
	#name : 'SpOpenOnNilExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'text'
	],
	#category : 'Spec2-Examples-Wrapper',
	#package : 'Spec2-Examples',
	#tag : 'Wrapper'
}

{ #category : 'examples' }
SpOpenOnNilExample class >> example [

	<sampleInstance>
	^ self new
		  extent: 200 @ 100;
		  open;
		  yourself
]

{ #category : 'layout' }
SpOpenOnNilExample >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: text expand: false;
		  yourself
]

{ #category : 'initialization' }
SpOpenOnNilExample >> initialize: anInteger [
	text label: anInteger asString
]

{ #category : 'initialization' }
SpOpenOnNilExample >> initializePresenters [
	text := self instantiate: SpTextInputFieldPresenter.
	text
		text: 'Object is nil';
		enabled: false.
]

{ #category : 'accessing' }
SpOpenOnNilExample >> text [
	^ text
]

{ #category : 'accessing' }
SpOpenOnNilExample >> title [
	^ 'OpenOnNilExample'
]
