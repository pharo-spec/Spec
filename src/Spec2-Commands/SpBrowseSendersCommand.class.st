Class {
	#name : #SpBrowseSendersCommand,
	#superclass : #SpSystemNavigationCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #defaults }
SpBrowseSendersCommand class >> defaultIconName [
	^#smallSystemBrowser 
]

{ #category : #default }
SpBrowseSendersCommand class >> defaultName [

	^ 'Browse senders'
]

{ #category : #default }
SpBrowseSendersCommand class >> defaultShortcutKey [

	^ $n command mac 
		| $n control win
		| $n control unix
]

{ #category : #executing }
SpBrowseSendersCommand >> execute [
	self systemNavigation browseAllSendersOf: self selector
]
