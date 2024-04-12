"
A dialog to present some simple information to users.
"
Class {
	#name : 'SpAlertDialog',
	#superclass : 'SpAbstractMessageDialog',
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'accessing' }
SpAlertDialog class >> defaultAcceptLabel [

	^ 'Ok'
]

{ #category : 'accessing' }
SpAlertDialog class >> defaultExtent [

	^ 450@120
]

{ #category : 'documentation' }
SpAlertDialog class >> documentFactoryMethodSelector [
	
	^ #newInform
]

{ #category : 'examples' }
SpAlertDialog class >> example [

	self new
		title: 'Alert example';
		label: 'You are seeing an alert dialog!';
		acceptLabel: 'Close this!';
		openDialog
]

{ #category : 'examples' }
SpAlertDialog class >> exampleModal [

	self new
		title: 'Alert modal example';
		label: 'You are seeing an alert dialog!';
		acceptLabel: 'Close this!';
		openModal
]

{ #category : 'examples' }
SpAlertDialog class >> exampleMultiLineLabel [

	| label |
	label := String streamContents: [ :s |
		s nextPutAll: 'Select a class';
		  cr;
		  cr;
		  nextPutAll: 'Something else two lines bellow with a really long long long long text that will wrap'
		 ].	


	self new
		title: 'Alert example';
		label: label;
		acceptLabel: 'Close this!';
		openDialog
]

{ #category : 'private' }
SpAlertDialog >> defaultIcon [

	^ self application iconNamed: #info
]

{ #category : 'accessing' }
SpAlertDialog >> defaultTitle [

	^ 'Inform'
]
