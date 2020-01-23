Class {
	#name : #SpCodeBrowseItCommand,
	#superclass : #SpCodeBrowsingCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #default }
SpCodeBrowseItCommand class >> defaultIconName [
	^#smallSystemBrowser
]

{ #category : #default }
SpCodeBrowseItCommand class >> defaultName [

	^ 'Browse it'
]

{ #category : #default }
SpCodeBrowseItCommand class >> defaultShortcutKey [

	^ $b command mac 
		| $b control win
		| $b control unix
]

{ #category : #execution }
SpCodeBrowseItCommand >> execute [
	context findClassFromSelection ifNotNil: [ :class | class browse ]
]
