"
Description
--------------------

Demo for the labelled presenter
"
Class {
	#name : #SpDemoLabeledPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'email',
		'password'
	],
	#category : #'Spec2-Examples-Demo-Labeled'
}

{ #category : #layout }
SpDemoLabeledPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: email expand: false;
		add: password expand: false;
		yourself
]

{ #category : #initialization }
SpDemoLabeledPresenter >> initializePresenters [
	| passwordInput |

	passwordInput := self newTextInput
		bePassword;
		yourself.
		
	email := self instantiate: (SpLabeledPresenter 
		label: 'Email' 
		input: self newTextInput 
		description: 'Email you will use to send activations mails to your users.').
	password := self instantiate: (SpLabeledPresenter 
		label: 'Password' 
		input: passwordInput 
		description: 'Password of the email account used.')
]
