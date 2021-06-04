"
Browse all methods matching the selected string (case-insensitive).
"
Class {
	#name : #SpBrowseMethodsMatchingStringInsensitiveCommand,
	#superclass : #SpSystemSelectionCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #default }
SpBrowseMethodsMatchingStringInsensitiveCommand class >> shortName [

	^ 'methods literal strings (case-insensitive)'
]

{ #category : #executing }
SpBrowseMethodsMatchingStringInsensitiveCommand >> execute [

	self context doBrowseMethodsMatchingStringSensitive
]
