Class {
	#name : #SpBrowseMethodsContainingStringCommand,
	#superclass : #SpSystemNavigationCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #defaults }
SpBrowseMethodsContainingStringCommand class >> defaultIconName [
	^#smallSystemBrowser 
]

{ #category : #default }
SpBrowseMethodsContainingStringCommand class >> defaultName [

	^ 'Browse methods containing string'
]

{ #category : #executing }
SpBrowseMethodsContainingStringCommand >> execute [
	self systemNavigation browseMethodsWithSourceString: context selectedText matchCase: false
]
