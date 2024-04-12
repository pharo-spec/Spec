"
A simple confirm dialog. 
By default, it will show the `label` message and ask for a conformation with `Yes` and `No` as default button options.

"
Class {
	#name : 'SpConfirmDialog',
	#superclass : 'SpAbstractCancelableMessageDialog',
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'accessing' }
SpConfirmDialog class >> defaultAcceptLabel [

	^ 'Yes'
]

{ #category : 'accessing' }
SpConfirmDialog class >> defaultCancelLabel [

	^ 'No'
]

{ #category : 'accessing' }
SpConfirmDialog class >> defaultExtent [

	^ 450@120
]

{ #category : 'documentation' }
SpConfirmDialog class >> documentFactoryMethodSelector [
	
	^ #newConfirm
]

{ #category : 'examples' }
SpConfirmDialog class >> example [

	| dialog |
	dialog := self new.
	^ dialog
		  title: 'Confirm example';
		  label: 'Are you sure?';
		  acceptLabel: 'Sure!';
		  cancelLabel: 'No, forget it';
		  onAccept: [
			  dialog inform: 'Yes!' ];
		  onCancel: [
			  dialog inform: 'No!' ];
		  openDialog
]

{ #category : 'examples' }
SpConfirmDialog class >> exampleModal [

	| ok dialog |
	dialog := self new.
	ok := dialog
		      title: 'Confirm modal example';
		      label: 'Are you sure?';
		      acceptLabel: 'Sure!';
		      cancelLabel: 'No, forget it';
		      openModal.

	dialog inform: (ok
				 ifTrue: [ 'Yes!' ]
				 ifFalse: [ 'No!' ])
]

{ #category : 'examples' }
SpConfirmDialog class >> exampleMultiLineLabel [ 

	| dialog label|

	label := String streamContents: [ :s |
		s nextPutAll: 'Are you sure?';
		  cr;
		  cr;
		  nextPutAll: 'Something else two lines bellow with a really long long long long text that will wrap'
		 ].	

	dialog := self new.
	^ dialog
		  title: 'Confirm example';
		  label: label;
		  acceptLabel: 'Sure!';
		  cancelLabel: 'No, forget it';
		  onAccept: [
			  dialog inform: 'Yes!' ];
		  onCancel: [
			  dialog inform: 'No!' ];
		  openDialog
]

{ #category : 'accessing' }
SpConfirmDialog >> defaultTitle [

	^ 'Confirm'
]

{ #category : 'api - showing' }
SpConfirmDialog >> openModal [
	| dialog |
	
	dialog := super openModal.
	^ dialog isOk
]
