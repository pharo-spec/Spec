"
Browse all methods matching the selected string (case-insensitive).
"
Class {
	#name : 'SpBrowseMethodsMatchingStringInsensitiveCommand',
	#superclass : 'SpSystemSelectionCommand',
	#category : 'Spec2-Commands-Navigation',
	#package : 'Spec2-Commands',
	#tag : 'Navigation'
}

{ #category : 'default' }
SpBrowseMethodsMatchingStringInsensitiveCommand class >> defaultDescription [

	^ 'Browse all methods containing a string matchign the selected string (case-sensitive)'
]

{ #category : 'default' }
SpBrowseMethodsMatchingStringInsensitiveCommand class >> defaultName [

	^ 'Strings with it (case insensitive)'
]

{ #category : 'defaults' }
SpBrowseMethodsMatchingStringInsensitiveCommand class >> defaultShortcutKey [

	^ $e shift actionModifier
]

{ #category : 'default' }
SpBrowseMethodsMatchingStringInsensitiveCommand class >> shortName [

	^ nil "Do not use"
]

{ #category : 'executing' }
SpBrowseMethodsMatchingStringInsensitiveCommand >> execute [

	self context doBrowseMethodsMatchingStringInsensitive
]
