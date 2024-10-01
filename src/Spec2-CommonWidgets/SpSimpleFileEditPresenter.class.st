"
I define a simple code editor. 
Before saving I create a backup of the edited file. 


Here is a typical use: 

```
SpSimpleFileEditPresenter new 
	onFileReference: '/Library/Preferences/pharo/6.0/settings.st' asFileReference;
	openDialog 
```
"
Class {
	#name : 'SpSimpleFileEditPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'label',
		'fileReference',
		'codeText'
	],
	#category : 'Spec2-CommonWidgets',
	#package : 'Spec2-CommonWidgets'
}

{ #category : 'examples' }
SpSimpleFileEditPresenter class >> example [
	<script>
	
	| presenter fm |
	fm := FileSystem memory / 'unknow.st'.
	fm writeStreamDo: [ :each | each nextPutAll: 'Please edit me and save me!' ].
	presenter := self new.
	presenter
		label: 'The meaning of life?';
		onFileReference: fm ;
		openDialog
]

{ #category : 'layout' }
SpSimpleFileEditPresenter >> backupFileReference [
	
	| basename nameWithoutExtension |
	basename := fileReference basename.
	nameWithoutExtension :=  fileReference basenameWithoutExtension.
	^ fileReference parent / (nameWithoutExtension, 'Old.txt')
]

{ #category : 'layout' }
SpSimpleFileEditPresenter >> calculateLabelHeight [

	^ 16
]

{ #category : 'layout' }
SpSimpleFileEditPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		spacing: 5;
	  	add: (SpBoxLayout newLeftToRight
				add: label expand: true;
				yourself)
	  		height: self calculateLabelHeight;
		add: codeText expand: true;
		yourself
]

{ #category : 'initialization' }
SpSimpleFileEditPresenter >> initializeDialogWindow: aDialog [

	super initializeDialogWindow: aDialog.
	aDialog
		okAction: [ :presenter | self save ];
		cancelAction: [ :presenter | self inform: 'Did not save' ]
]

{ #category : 'layout' }
SpSimpleFileEditPresenter >> initializePresenters [

	label := self newLabel.
	codeText := self newCode.
	codeText takeKeyboardFocus.
]

{ #category : 'layout' }
SpSimpleFileEditPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'File edit';
		initialExtent: 600@600
]

{ #category : 'accessing' }
SpSimpleFileEditPresenter >> label [

	^ label
]

{ #category : 'accessing' }
SpSimpleFileEditPresenter >> label: anObject [

	label := anObject
]

{ #category : 'layout' }
SpSimpleFileEditPresenter >> onFileReference: aFileReference [

	fileReference := aFileReference. 
	codeText text: aFileReference contents.
	label label: 'File: ...',  (aFileReference fullName last: 45)
]

{ #category : 'layout' }
SpSimpleFileEditPresenter >> save [

	self backupFileReference ensureDelete.
	self saveBackup.
	fileReference ensureDelete.
	fileReference writeStreamDo: [ :stream | stream nextPutAll: (codeText selectAll; text) ].


	
]

{ #category : 'layout' }
SpSimpleFileEditPresenter >> saveBackup [
	
	fileReference copyTo: self backupFileReference.
	
]

{ #category : 'accessing' }
SpSimpleFileEditPresenter >> textInput [

	^ codeText
]

{ #category : 'accessing' }
SpSimpleFileEditPresenter >> textInput: anObject [

	codeText := anObject
]
