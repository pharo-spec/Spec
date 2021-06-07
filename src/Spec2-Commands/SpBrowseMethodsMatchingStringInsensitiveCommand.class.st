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

{ #category : #accessing }
SpBrowseMethodsMatchingStringInsensitiveCommand class >> shortName [

	^ nil
]

{ #category : #executing }
SpBrowseMethodsMatchingStringInsensitiveCommand >> execute [

	self context doBrowseMethodsMatchingStringSensitive
]
