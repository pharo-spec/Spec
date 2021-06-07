"
Browse all methods matching the selected string (case-sensitive).
"
Class {
	#name : #SpBrowseMethodsMatchingStringSensitiveCommand,
	#superclass : #SpSystemSelectionCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #default }
SpBrowseMethodsMatchingStringSensitiveCommand class >> defaultDescription [
	^ 'Browse all methods containing a string matchign the selected string (case-sensitive)'
]

{ #category : #default }
SpBrowseMethodsMatchingStringSensitiveCommand class >> defaultName [

	^ 'Case sensitive method literal strings with it'
]

{ #category : #default }
SpBrowseMethodsMatchingStringSensitiveCommand class >> shortName [

	^ nil
]

{ #category : #executing }
SpBrowseMethodsMatchingStringSensitiveCommand >> execute [

	self context doBrowseMethodsMatchingStringSensitive
]
