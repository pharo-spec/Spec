"
I browse all references to the computed context that is transformed to a symbol.
"
Class {
	#name : 'SpBrowseMethodReferencesCommand',
	#superclass : 'SpSystemSelectionCommand',
	#category : 'Spec2-Commands-Navigation',
	#package : 'Spec2-Commands',
	#tag : 'Navigation'
}

{ #category : 'default' }
SpBrowseMethodReferencesCommand class >> defaultDescription [
	^ 'Browse all references to the selected method or selector'
]

{ #category : 'default' }
SpBrowseMethodReferencesCommand class >> defaultName [ 

	^ 'References to it'
]

{ #category : 'default' }
SpBrowseMethodReferencesCommand class >> defaultShortcutKey [

	^ $n command shift mac 
		| $n control shift win
		| $n control shift unix
]

{ #category : 'default' }
SpBrowseMethodReferencesCommand class >> shortName [

	^ 'references'
]

{ #category : 'executing' }
SpBrowseMethodReferencesCommand >> execute [

	self context doBrowseMethodReferences
]
