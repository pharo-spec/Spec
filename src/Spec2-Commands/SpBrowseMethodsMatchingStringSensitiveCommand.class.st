"
Browse all methods matching the selected string (case-sensitive).
"
Class {
	#name : 'SpBrowseMethodsMatchingStringSensitiveCommand',
	#superclass : 'SpSystemSelectionCommand',
	#category : 'Spec2-Commands-Navigation',
	#package : 'Spec2-Commands',
	#tag : 'Navigation'
}

{ #category : 'default' }
SpBrowseMethodsMatchingStringSensitiveCommand class >> defaultDescription [
	^ 'Browse all methods containing a string matchign the selected string (case-sensitive)'
]

{ #category : 'default' }
SpBrowseMethodsMatchingStringSensitiveCommand class >> defaultName [

	^ 'Case sensitive method literal strings with it'
]

{ #category : 'defaults' }
SpBrowseMethodsMatchingStringSensitiveCommand class >> defaultShortcutKey [

	^ $u command shift mac
		| $u control shift win
		| $u control shift unix
]

{ #category : 'default' }
SpBrowseMethodsMatchingStringSensitiveCommand class >> shortName [

	^ 'methods literal strings (case-sensitive)'
]

{ #category : 'executing' }
SpBrowseMethodsMatchingStringSensitiveCommand >> execute [

	self context doBrowseMethodsMatchingStringSensitive
]
