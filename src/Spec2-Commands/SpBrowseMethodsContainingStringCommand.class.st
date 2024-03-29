"
I browse all methods containing a string returned by the computed context.
"
Class {
	#name : 'SpBrowseMethodsContainingStringCommand',
	#superclass : 'SpSystemSelectionCommand',
	#category : 'Spec2-Commands-Navigation',
	#package : 'Spec2-Commands',
	#tag : 'Navigation'
}

{ #category : 'default' }
SpBrowseMethodsContainingStringCommand class >> defaultDescription [

	^ 'Browse all methods containing the selected string'
]

{ #category : 'default' }
SpBrowseMethodsContainingStringCommand class >> defaultName [

	^ 'Method source with it'
]

{ #category : 'default' }
SpBrowseMethodsContainingStringCommand class >> shortName [

	^ 'methods containing string'
]

{ #category : 'executing' }
SpBrowseMethodsContainingStringCommand >> execute [

	self context doBrowseMethodsContainingString
]
