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
	^ (SpGridLayout build: [ :builder |
		builder 
			add: 'Normal:';
			add: fieldNormal;
			nextRow;
			add: 'Disabled:';
			add: fieldDisabled;
			nextRow;
			add: 'Placeholder:';
			add: fieldPlaceholderText;
			nextRow;
			add: 'Password:';
			add: fieldEncrypted ])
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
	
	fieldDisabled := self newTextInput enabled: false.
	
	fieldPlaceholderText := self newTextInput placeholder: 'Placeholder text'.
	
	fieldEncrypted := self newTextInput
		text: 'Password';
		bePassword
]
