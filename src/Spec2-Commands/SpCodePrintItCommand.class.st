Class {
	#name : #SpCodePrintItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #default }
SpCodePrintItCommand class >> defaultName [

	^ 'Print it'
]

{ #category : #default }
SpCodePrintItCommand class >> defaultShortcutKey [

	^ $p meta
]

{ #category : #execution }
SpCodePrintItCommand >> execute [

	context crLog.
]
