Class {
	#name : #SpCodeInspectItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #default }
SpCodeInspectItCommand class >> defaultName [

	^ 'Inspect it'
]

{ #category : #default }
SpCodeInspectItCommand class >> defaultShortcutKey [

	^ $i meta
]

{ #category : #execution }
SpCodeInspectItCommand >> execute [

	'OK' crLog
]
