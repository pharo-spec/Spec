"
This demo shows differenty styles of text inputs.
"
Class {
	#name : #SpDemoTextInputPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'fieldNormal',
		'fieldDisabled',
		'fieldEncrypted',
		'fieldPlaceholderText'
	],
	#category : #'Spec2-Examples-Demo-TextInput'
}

{ #category : #examples }
SpDemoTextInputPresenter class >> example [
	^ self new open
]

{ #category : #layout }
SpDemoTextInputPresenter >> defaultLayout [

	^ SpGridLayout new
		  add: 'Normal:' at: 1 @ 1;
		  add: fieldNormal at: 2 @ 1 span: 2 @ 1;
		  add: 'Disabled:' at: 1 @ 2;
		  add: fieldDisabled at: 2 @ 2 span: 2 @ 1;
		  add: 'Placeholder:' at: 1 @ 3;
		  add: fieldPlaceholderText at: 2 @ 3 span: 2 @ 1;
		  add: 'Password:' at: 1 @ 4;
		  add: fieldEncrypted at: 2 @ 4 span: 2 @ 1;
		  beColumnNotHomogeneous;
		  yourself
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldDisabled [
	^ fieldDisabled
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldDisabled: anObject [
	fieldDisabled := anObject
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldEncrypted [
	^ fieldEncrypted
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldEncrypted: anObject [
	fieldEncrypted := anObject
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldNormal [
	^ fieldNormal
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldNormal: anObject [
	fieldNormal := anObject
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldPlaceholderText [
	^ fieldPlaceholderText
]

{ #category : #accessing }
SpDemoTextInputPresenter >> fieldPlaceholderText: anObject [
	fieldPlaceholderText := anObject
]

{ #category : #initialization }
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
