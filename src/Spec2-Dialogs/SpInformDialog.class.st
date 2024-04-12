"
I'm notification based interaction with the user. I'm not modal and I'm under development
"
Class {
	#name : 'SpInformDialog',
	#superclass : 'SpAbstractMessageDialog',
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'accessing' }
SpInformDialog class >> defaultAcceptLabel [

	^ 'Ok'
]

{ #category : 'accessing' }
SpInformDialog class >> defaultExtent [

	^ 450@120
]

{ #category : 'documentation' }
SpInformDialog class >> documentFactoryMethodSelector [
	
	^ #newInform
]

{ #category : 'examples' }
SpInformDialog class >> example [

	self new
		title: 'Inform example';
		label: 'You are seeing an inform dialog!';
		acceptLabel: 'Close this!';
		openDialog
]

{ #category : 'examples' }
SpInformDialog class >> exampleModal [

	self new
		title: 'Inform modal example';
		label: 'You are seeing an inform dialog!';
		acceptLabel: 'Close this!';
		openModal
]

{ #category : 'examples' }
SpInformDialog class >> exampleMultiLineLabel [ 

	| label |

	label := String streamContents: [ :s |
		s nextPutAll: 'You are seeing an inform dialog!';
		  cr;
		  cr;
		  nextPutAll: 'Something else two lines bellow with a really long long long long text that will wrap'
		 ].	

	self new
		title: 'Inform modal example';
		label: label;
		acceptLabel: 'Close this!';
		openModal
]

{ #category : 'accessing' }
SpInformDialog >> defaultIcon [

	^ self application iconNamed: #info
]

{ #category : 'accessing' }
SpInformDialog >> defaultTitle [

	^ 'Inform'
]
