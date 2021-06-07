"
I browse all references to the computed context that is transformed to a symbol.
"
Class {
	#name : #SpBrowseMethodReferencesCommand,
	#superclass : #SpSystemSelectionCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #default }
SpBrowseMethodReferencesCommand class >> defaultDescription [
	^ 'Browse all references to the selected method or selector'
]

{ #category : #default }
SpBrowseMethodReferencesCommand class >> defaultName [ 

	^ 'References of it'
]

{ #category : #default }
SpBrowseMethodReferencesCommand class >> defaultShortcutKey [

	^ $n command shift mac 
		| $n control shift win
		| $n control shift unix
]

{ #category : #default }
SpBrowseMethodReferencesCommand class >> shortName [

	^ nil
]

{ #category : #executing }
SpBrowseMethodReferencesCommand >> execute [

	self context doBrowseMethodReferences
]
