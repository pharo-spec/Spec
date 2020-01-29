"
I browse the inheritance of a method - my context must evaluate to a method.
"
Class {
	#name : #SpBrowseMethodInheritanceCommand,
	#superclass : #SpSystemNavigationCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #defaults }
SpBrowseMethodInheritanceCommand class >> defaultIconName [
	^#smallSystemBrowser 
]

{ #category : #default }
SpBrowseMethodInheritanceCommand class >> shortName [

	^ 'method inheritance'
]

{ #category : #executing }
SpBrowseMethodInheritanceCommand >> execute [
	self systemNavigation
		methodHierarchyBrowserForClass: self context methodClass
		selector: self context selector
]
