Class {
	#name : #SpCodeDoItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #default }
SpCodeDoItCommand class >> defaultName [

	^ 'Do it'
]

{ #category : #default }
SpCodeDoItCommand class >> defaultShortcutKey [

	^ $d meta
]

{ #category : #execution }
SpCodeDoItCommand >> execute [

	'OK' crLog
]
