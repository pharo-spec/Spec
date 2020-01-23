Class {
	#name : #SpBrowseReferencesCommand,
	#superclass : #SpSystemNavigationCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #defaults }
SpBrowseReferencesCommand class >> defaultIconName [
	^#smallSystemBrowser 
]

{ #category : #default }
SpBrowseReferencesCommand class >> defaultName [

	^ 'Browse references'
]

{ #category : #executing }
SpBrowseReferencesCommand >> execute [
	self systemNavigation browseAllReferencesTo: self selector
]
