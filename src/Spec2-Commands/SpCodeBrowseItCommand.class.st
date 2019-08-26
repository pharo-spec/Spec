Class {
	#name : #SpCodeBrowseItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #default }
SpCodeBrowseItCommand class >> defaultName [

	^ 'Browse it'
]

{ #category : #default }
SpCodeBrowseItCommand class >> defaultShortcutKey [

	^ $b meta
]

{ #category : #execution }
SpCodeBrowseItCommand >> execute [
	"Treat the current text selection as an expression; evaluate it."
	
	self selectionOrLine trimmed ifNotNil: [ :result | 
		self flag: #TODO. "this is just browseIt. I'm putting this now to show the flow"
		StSystemBrowser openOnClass: (Smalltalk classNamed: result) ]
]
