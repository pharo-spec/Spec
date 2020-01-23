Class {
	#name : #SpBrowseImplementorsCommand,
	#superclass : #SpSystemNavigationCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #defaults }
SpBrowseImplementorsCommand class >> defaultIconName [
	^#smallSystemBrowser 
]

{ #category : #default }
SpBrowseImplementorsCommand class >> defaultName [

	^ 'Browse implementors'
]

{ #category : #default }
SpBrowseImplementorsCommand class >> defaultShortcutKey [

	^ $m command mac 
		| $m control win
		| $m control unix
]

{ #category : #executing }
SpBrowseImplementorsCommand >> execute [
	self systemNavigation browseAllImplementorsOf: self selector
]
