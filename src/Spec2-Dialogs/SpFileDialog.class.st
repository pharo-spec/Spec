"
Wrapper to show the select or save file/folder dialogs.
Unlike regular presenters, this object will delegate directly to the system file dialog (when available).

As main vocabulary, it understands `openModal`, to provide a polymorphic entry point.
"
Class {
	#name : 'SpFileDialog',
	#superclass : 'Object',
	#instVars : [
		'title',
		'filters',
		'path',
		'application',
		'parentWindow',
		'action'
	],
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'instance creation' }
SpFileDialog class >> newApplication: anApplication [

	^ self new 
		application: anApplication;
		yourself
]

{ #category : 'api' }
SpFileDialog >> addFilter: aString [

	filters := self filters copyWith: aString
]

{ #category : 'accessing' }
SpFileDialog >> application [

	^ application
]

{ #category : 'accessing' }
SpFileDialog >> application: anApplication [

	application := anApplication
]

{ #category : 'api' }
SpFileDialog >> beOpenDirectory [

	action := #openDirectory
]

{ #category : 'api' }
SpFileDialog >> beOpenFile [

	action := #openFile
]

{ #category : 'api' }
SpFileDialog >> beSaveFile [

	action := #saveFile
]

{ #category : 'api' }
SpFileDialog >> doInteraction [
	
	^ self openModal
]

{ #category : 'api' }
SpFileDialog >> filters [

	^ filters ifNil: [ #() ]
]

{ #category : 'api' }
SpFileDialog >> filters: aCollectionOfStrings [
	"Receives a collection of file extentions. 
	 e.g. #('jpg' 'png')"

	filters := aCollectionOfStrings
]

{ #category : 'initialization' }
SpFileDialog >> initialize [

	super initialize.
	self beOpenFile
]

{ #category : 'testing' }
SpFileDialog >> isOpenDirectory [

	^ action = #openDirectory
]

{ #category : 'testing' }
SpFileDialog >> isOpenFile [

	^ action = #openFile
]

{ #category : 'testing' }
SpFileDialog >> isSaveFile [

	^ action = #saveFile
]

{ #category : 'api - showing' }
SpFileDialog >> openModal [

	^ self application backend openFileDialog: self
]

{ #category : 'accessing' }
SpFileDialog >> parentWindow [

	^ parentWindow
]

{ #category : 'accessing' }
SpFileDialog >> parentWindow: anObject [

	parentWindow := anObject
]

{ #category : 'api' }
SpFileDialog >> path [

	^ path
]

{ #category : 'api' }
SpFileDialog >> path: aStringOrFileReference [
	"initial value of the dialog"
	
	path := aStringOrFileReference asFileReference
]

{ #category : 'api' }
SpFileDialog >> title [

	^ title
]

{ #category : 'api' }
SpFileDialog >> title: aTitle [

	title := aTitle
]
