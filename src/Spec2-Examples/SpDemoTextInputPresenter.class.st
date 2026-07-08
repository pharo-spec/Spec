"
This demo shows differenty styles of text inputs.
"
Class {
	#name : 'SpDemoTextInputPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'fieldNormal',
		'fieldDisabled',
		'fieldEncrypted',
		'fieldPlaceholderText'
	],
	#category : 'Spec2-Examples-Demo-TextInput',
	#package : 'Spec2-Examples',
	#tag : 'Demo-TextInput'
}

{ #category : 'examples' }
SpDemoTextInputPresenter class >> example [
	^ self new open
]

{ #category : 'layout' }
SpDemoTextInputPresenter >> defaultLayout [

	^ SpGridLayout new
		  add: 'Normal:' atPoint: 1 @ 1;
		  add: fieldNormal atPoint: 2 @ 1 span: 2 @ 1;
		  add: 'Disabled:' atPoint: 1 @ 2;
		  add: fieldDisabled atPoint: 2 @ 2 span: 2 @ 1;
		  add: 'Placeholder:' atPoint: 1 @ 3;
		  add: fieldPlaceholderText atPoint: 2 @ 3 span: 2 @ 1;
		  add: 'Password:' atPoint: 1 @ 4;
		  add: fieldEncrypted atPoint: 2 @ 4 span: 2 @ 1;
		  beColumnNotHomogeneous;
		  yourself
]

{ #category : 'accessing' }
SpDemoTextInputPresenter >> fieldDisabled [
	^ fieldDisabled
]

{ #category : 'accessing' }
SpDemoTextInputPresenter >> fieldDisabled: anObject [
	fieldDisabled := anObject
]

{ #category : 'accessing' }
SpDemoTextInputPresenter >> fieldEncrypted [
	^ fieldEncrypted
]

{ #category : 'accessing' }
SpDemoTextInputPresenter >> fieldEncrypted: anObject [
	fieldEncrypted := anObject
]

{ #category : 'accessing' }
SpDemoTextInputPresenter >> fieldNormal [
	^ fieldNormal
]

{ #category : 'accessing' }
SpDemoTextInputPresenter >> fieldNormal: anObject [
	fieldNormal := anObject
]

{ #category : 'accessing' }
SpDemoTextInputPresenter >> fieldPlaceholderText [
	^ fieldPlaceholderText
]

{ #category : 'accessing' }
SpDemoTextInputPresenter >> fieldPlaceholderText: anObject [
	fieldPlaceholderText := anObject
]

{ #category : 'initialization' }
SpDemoTextInputPresenter >> initializePresenters [

	fieldNormal := self newTextInput.

	fieldDisabled := self newTextInput
		editable: false;
		yourself.

	fieldPlaceholderText := self newTextInput
		placeholder: 'Placeholder text';
		yourself.

	fieldEncrypted := self newTextInput
		text: 'Password';
		bePassword;
		yourself
]
