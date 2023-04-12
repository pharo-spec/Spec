"
Browse all methods matching the selected string (case-insensitive).
"
Class {
	#name : #SpBrowseMethodsMatchingStringInsensitiveCommand,
	#superclass : #SpSystemSelectionCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #default }
SpBrowseMethodsMatchingStringInsensitiveCommand class >> defaultDescription [

	^ 'Browse all methods containing a string matchign the selected string (case-sensitive)'
]

{ #category : #default }
SpBrowseMethodsMatchingStringInsensitiveCommand class >> defaultName [

	^ 'Case insensitive method literal strings with it'
]

{ #category : #defaults }
SpBrowseMethodsMatchingStringInsensitiveCommand class >> defaultShortcutKey [

	^ $e command shift mac
		| $e control shift win
		| $e control shift unix
]

{ #category : #default }
SpBrowseMethodsMatchingStringInsensitiveCommand class >> shortName [

	^ nil "Do not use"
]

{ #category : #executing }
SpBrowseMethodsMatchingStringInsensitiveCommand >> execute [

	self context doBrowseMethodsMatchingStringInsensitive
]
