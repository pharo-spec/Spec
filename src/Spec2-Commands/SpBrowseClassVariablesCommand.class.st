"
My context is a class, I browse the class variables of that class.
"
Class {
	#name : #SpBrowseClassVariablesCommand,
	#superclass : #SpSystemNavigationCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #defaults }
SpBrowseClassVariablesCommand class >> defaultIconName [
	^#smallSystemBrowser 
]

{ #category : #default }
SpBrowseClassVariablesCommand class >> shortName [

	^ 'class variables'
]

{ #category : #executing }
SpBrowseClassVariablesCommand >> execute [	
	self systemNavigation browseClassVariables: self context
]
