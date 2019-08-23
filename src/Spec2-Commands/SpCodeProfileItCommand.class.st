Class {
	#name : #SpCodeProfileItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #default }
SpCodeProfileItCommand class >> defaultName [

	^ 'Profile it'
]

{ #category : #accessing }
SpCodeProfileItCommand >> defaultMenuItemName [

	^ 'Profile it'
]

{ #category : #execution }
SpCodeProfileItCommand >> execute [

	'OK' crLog
]
